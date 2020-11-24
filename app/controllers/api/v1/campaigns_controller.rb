module Api
  module V1
    class CampaignsController < ApplicationController
      def create
        result = Campaigns::CampaignCreationService.new(campaign_params).call

        if result.is_a? Success
          render json: result.value!
        else
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
