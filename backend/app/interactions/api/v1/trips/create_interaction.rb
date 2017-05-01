module Api
  module V1
    module Trips
      class CreateInteraction < Api::V1::ApplicationInteraction
        hash :data do
          hash :attributes do
            date :end_date, default: nil
            date :start_date, default: nil

            string :comment, default: ''
            string :destination

            integer :user_id, default: nil
          end
        end

        def execute
          add_errors(trip.errors) unless action

          serialize(trip)
        end

        private

        def action
          trip.save
        end

        def trip
          @_trip ||= Trip.new(permitted_attributes)
        end

        def permitted_attributes
          attributes = data[:attributes]

          attributes[:user_id] = current_user.admin? && data[:attributes][:user_id] || current_user.id

          attributes.compact
        end

        def authorized?
          user_id == current_user.id || current_user.admin?
        end
      end
    end
  end
end
