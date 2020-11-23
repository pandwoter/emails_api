module Delivery
  class EmailDeliveryWorker < AbstractWorker
    def perform(campaign_id)
      result = Delivery::EmailDeliveryService.new(campaign_id).call

      case result
      when Failure
        reschedule(campaign_id)
      end
    end

    private

    def reschedule(campaign_id)
      Rails.logger.info { "[#{self.class}] it seems all email providers are down, retrying" }
      EmailDeliveryWorker.perform_in(2.minutes, campaign_id)
    end
  end
end
