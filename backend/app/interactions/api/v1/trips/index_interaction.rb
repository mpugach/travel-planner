module Api
  module V1
    module Trips
      class IndexInteraction < Api::V1::ApplicationInteraction
        date :max_end_date, default: nil
        date :min_start_date, default: nil

        string :trips_term, default: nil

        integer :user_id, default: nil

        def execute
          serialize(trips, is_collection: true)
        end

        private

        def trips
          collection = Trip.order(:start_date, :end_date)
          collection = collection.fts(trips_term) if trips_term.present?
          collection = collection.where('"end_date" <= ?', max_end_date) if max_end_date.present?
          collection = collection.where('"start_date" >= ?', min_start_date) if min_start_date.present?

          collection.where(user_id: current_user.admin? && user_id || current_user.id)
        end

        def authorized?
          user_id == current_user.id || current_user.admin?
        end
      end
    end
  end
end
