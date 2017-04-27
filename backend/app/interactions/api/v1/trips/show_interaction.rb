module Api
  module V1
    module Trips
      class ShowInteraction < Api::V1::ApplicationInteraction
        include Api::V1::Trips::Concerns::Crudable

        def execute
          serialize(trip)
        end
      end
    end
  end
end
