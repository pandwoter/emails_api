module Api

  module V1

    class CampaignsController < ApplicationController

      def create; end

      def show; end

      private

      def campaign_params
        params.require(:campaign).permit(:recipients, :subject, :message)
      end

    end

  end

end
