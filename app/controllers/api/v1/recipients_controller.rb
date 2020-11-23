module Api
  module V1
    class RecipientsController < ApplicationController
      def index
        _, recipients = pagy(Recipient.all)

        render json: recipients
      end

      def show
        render json: Recipient.find(params[:id])
      end
    end
  end
end
