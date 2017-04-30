module Api
  module V1
    class TripsController < Api::V1::ApplicationController
      def show
        render_interaction Api::V1::Trips::ShowInteraction
      end

      def index
        render_interaction Api::V1::Trips::IndexInteraction
      end

      def create
        render_interaction Api::V1::Trips::CreateInteraction
      end

      def update
        render_interaction Api::V1::Trips::UpdateInteraction
      end
    end
  end
end
