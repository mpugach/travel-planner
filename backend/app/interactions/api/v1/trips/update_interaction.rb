module Api
  module V1
    module Trips
      class UpdateInteraction < Api::V1::Trips::CreateInteraction
        include Api::V1::Trips::Concerns::Crudable

        private

        def action
          trip.update(permitted_attributes)
        end
      end
    end
  end
end
