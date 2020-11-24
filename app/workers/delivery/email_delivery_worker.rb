module Delivery
  class EmailDeliveryWorker < BaseWorker
    def perform(campaign_id)
      result = Delivery::EmailDeliveryService.new(campaign_id).call

      reschedule(campaign_id) if result.is_a? Failure
    end

    private

    def reschedule(campaign_id)
      Rails.logger.info { "[#{self.class}] it seems all email providers are down, retrying" }
      EmailDeliveryWorker.perform_in(2.minutes, campaign_id)
    end
  end
end
