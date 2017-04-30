module Api
  module V1
    module Trips
      class IndexInteraction < Api::V1::ApplicationInteraction
        def execute
          serialize(trips, is_collection: true)
        end

        private

        def trips
          collection = Trip.order(:start_date, :end_date)

          current_user.admin? ? collection : collection.where(user_id: current_user.id)
        end

        def authorized?
          current_user.present?
        end
      end
    end
  end
end
