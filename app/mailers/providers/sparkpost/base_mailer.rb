module Providers
  module Sparkpost
    class BaseMailer < ApplicationMailer
      default delivery_method: :sparkpost

      def errors_interceptor
        Success(yield)
      rescue ::SparkPostRails::DeliveryException => e
        Failure(e)
      end
    end
  end
end
