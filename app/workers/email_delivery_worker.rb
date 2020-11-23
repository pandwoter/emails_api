class EmailDeliveryWorker
  include Sidekiq::Worker

  def perform(campaign_id)
    result = Delivery::EmailDeliveryService.new(campaign_id).call

    case result
    when Failure
      Logger.info { "[#{self.class}] it seems all email providers are down, retrying" }
      perform_in(2.minutes, *args)
    end
  end
end
