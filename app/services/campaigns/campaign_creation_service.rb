module Campaigns
  class CampaignCreationService < BaseService
    include Dry::Monads::Do.for(:create_campaign_with_recipients)

    RECIPIENTS_FILTER = /\s*[,;]\s*|\s{2,}|[\r\n]+/x.freeze

    attr_reader :recipients, :subject, :message, :recipient_creation_service, :email_delivery_worker

    def initialize(
      params,
      email_delivery_worker = Delivery::EmailDeliveryWorker,
      recipient_creation_service = Recipients::RecipientCreationService
    )
      @subject    = params[:subject]
      @message    = params[:message]
      @recipients = params[:recipients]

      @email_delivery_worker      = email_delivery_worker
      @recipient_creation_service = recipient_creation_service
    end

    def call
      ActiveRecord::Base.transaction do
        @result = create_campaign_with_recipients
        raise ActiveRecord::Rollback if @result.is_a? Failure
      end

      @result
    end

    private

    def create_campaign_with_recipients
      campaign   = yield create_campaign
      recipients = yield create_recipients

      attach_recipients_to_campaign(recipients, campaign)
      schedule_delivery(campaign.id)

      Success(campaign)
    end

    def attach_recipients_to_campaign(recipients, campaign)
      campaign.recipients << recipients

      campaign
    end

    def create_campaign
      campaign = Campaign.create!(
        subject: subject,
        message: message,
        delivery_state: 'pending'
      )

      Success(campaign)
    rescue ActiveRecord::RecordInvalid => e
      Failure(e.record.errors.to_h)
    end

    def schedule_delivery(campaign_id)
      email_delivery_worker.perform_async(campaign_id)
    end

    def create_recipients
      List[*parsed_recipients.map { |r| recipient_creation_service.new(r).call }]
        .typed(Dry::Monads::Result)
        .traverse
    end

    def parsed_recipients
      recipients.split(RECIPIENTS_FILTER)
    end
  end
end
