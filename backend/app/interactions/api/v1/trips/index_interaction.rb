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
          collection = collection.fts(trips_term) unless trips_term.blank?
          collection = collection.where('"end_date" <= ?', max_end_date) unless max_end_date.blank?
          collection = collection.where('"start_date" >= ?', min_start_date) unless min_start_date.blank?

          collection.where(user_id: current_user.admin? && user_id || current_user.id)
        end

        def authorized?
          current_user.present?
        end
      end
    end
  end
end
