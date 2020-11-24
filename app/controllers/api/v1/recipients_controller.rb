module Api
  module V1
    class RecipientsController < ApplicationController
      def index
        @recipients = paginate Recipient.all

        render json: @recipients
      end

      def show
        @recipients = Recipient.find(params[:id])

        render json: @recipients
      end
    end
  end
end
