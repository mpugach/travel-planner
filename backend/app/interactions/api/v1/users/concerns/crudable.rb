module Api
  module V1
    module Users
      module Concerns
        module Crudable
          private

          def user
            @_user ||= User.find(id)
          end

          def authorized?
            id == current_user.id || current_user.can_manage_users? && sufficient_level?
          end

          def sufficient_level?
            User.roles[current_user.role] >= User.roles[user.role]
          end
        end
      end
    end
  end
end
