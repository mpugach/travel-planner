module Api
  module V1
    class TripsController < Api::V1::ApplicationController
      def create
        render_interaction Api::V1::Trips::CreateInteraction
      end
    end
  end
end
