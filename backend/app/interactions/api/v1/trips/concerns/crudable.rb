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
            @_trip ||= Trip.find(id)
          end

          def authorized?
            id == current_user.id || current_user.admin?
          end
        end
      end
    end
  end
end
