module Api
  module V1
    module Trips
      module Concerns
        module Crudable
          extend ActiveSupport::Concern

          included do
            integer :id
          end

          private

          def trip
            @_trip ||= Trip.where(id: id).first
          end

          def authorized?
            trip.present? && (trip.user_id == current_user.id || current_user.admin?)
          end
        end
      end
    end
  end
end
