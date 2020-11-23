module Providers
  module Aws
    class BaseMailer < ApplicationMailer
      default from: ENV['AWS_PROVIDER_DOMAIN'], delivery_method: :ses

      def errors_interceptor
        Success(yield)
      rescue ::Aws::SES::Errors => e
        Failure(e)
      end
    end
  end
end
