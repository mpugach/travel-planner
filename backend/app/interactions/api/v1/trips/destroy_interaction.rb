module Api
  module V1
    module Trips
      class DestroyInteraction < Api::V1::ApplicationInteraction
        include Api::V1::Trips::Concerns::Crudable

        def execute
          trip.destroy

          serialize(trip)
        end
      end
    end
  end
end
