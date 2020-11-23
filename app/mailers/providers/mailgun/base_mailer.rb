module Providers
  module Mailgun
    class BaseMailer < ApplicationMailer
      default from: ENV['MAILGUN_PROVIDER_DOMAIN'], delivery_method: :mailgun

      def errors_interceptor
        Success(yield)
      rescue ::Mailgun::Error, ::Railgun::Error => e
        Failure(e)
      end
    end
  end
end
