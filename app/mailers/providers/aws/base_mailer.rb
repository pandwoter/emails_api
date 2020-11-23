module Providers
  module Aws
    class BaseMailer < ApplicationMailer
      default delivery_method: :ses

      def errors_interceptor
        Success(yield)
      rescue ::AWS::SES::ResponseError => e
        Failure(e)
      end
    end
  end
end
