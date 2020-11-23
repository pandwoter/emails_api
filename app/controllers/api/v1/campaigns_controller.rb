module Api
  module V1
    class CampaignsController < ApplicationController
      def create
        result = Campaigns::CampaignCreationService.new(campaign_params).call

        case result
        when Success
          render json: result.value!
        when Failure
          render json: result.failure, status: :unprocessable_entity
        end
      end

      private

      def campaign_params
        params.require(:campaign).permit(:recipients, :subject, :message)
      end
    end
  end
end
