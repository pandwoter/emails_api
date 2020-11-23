module Delivery
  class EmailDeliveryService < AbstractService
    attr_reader :campaign, :template_generation_method

    ENABLED_PROVIDERS = %w[Sparkpost Aws Mailgun].freeze

    def initialize(campaign_id, template_generation_method = 'campaign_mail')
      @campaign = Campaign.find(campaign_id)

      @template_generation_method = template_generation_method
    end

    def call
      ENABLED_PROVIDERS.each do |provider|
        result = perform_delivery(provider)
        return handle_success_delivery if result.is_a? Success
      end

      handle_failed_delivery
    end

    private

    def handle_success_delivery
      campaign.update!(delivery_date: DateTime.now, delivery_state: 'delivered')
      Success(campaign)
    end

    def handle_failed_delivery
      campaign.update!(delivery_state: 'failed')
      Failure(:all_providers_down)
    end

    def perform_delivery(provider)
      provider = provider_instance(provider)

      provider_error_interceptor(provider) do
        provider.send(template_generation_method, campaign).deliver!
      end
    end

    def provider_instance(provider)
      "Providers::#{provider}::BaseMailer".constantize.new
    end

    def provider_error_interceptor(provider)
      provider.errors_interceptor { yield }
    end
  end
end
