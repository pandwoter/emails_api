module Api
  module V1
    class RecipientsController < ApplicationController
      def index
        @recipients = Pagination::PaginationService.new(Recipient, params).call

        render json: @recipients
      end

      def show
        @recipients = Recipient.find(params[:id])

        render json: @recipients
      end
    end
  end
end
