module Campaigns
  class CampaignCreationService < AbstractService
    include Mixins::Transactionable

    RECIPIENTS_FILTER = /\s*[,;]\s*|\s{2,}|[\r\n]+/x.freeze

    attr_reader :recipients, :subject, :message, :recipient_creation_service

    def initialize(params, recipient_creation_service = Recipients::RecipientCreationService)
      @subject = params[:subject]
      @message = params[:message]
      @recipients = params[:recipients]

      @recipient_creation_service = recipient_creation_service
    end

    def call
      result = nil

      with_transaction do
        case result = create_campaign_with_recipients
        when Failure
          raise ActiveRecord::Rollback
        end
      end

      result
    end

    private

    def create_campaign_with_recipients
      create_campaign.bind do |campaign|
        create_recipients.fmap do |recipient|
          attach_recipients_to_campaign(recipient, campaign)
        end
      end
    end

    def attach_recipients_to_campaign(recipient, campaign)
      campaign.recipients << recipient

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
