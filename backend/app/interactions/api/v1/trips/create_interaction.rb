module Api
  module V1
    module Trips
      class CreateInteraction < Api::V1::ApplicationInteraction
        USER_ID = 'user_id'.freeze
        ATTRIBUTES = 'attributes'.freeze

        hash :data do
          hash :attributes do
            string :destination
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
          attributes = data[ATTRIBUTES]

          attributes[USER_ID] = current_user.id

          attributes.compact
        end

        def authorized?
          current_user.present?
        end
      end
    end
  end
end
