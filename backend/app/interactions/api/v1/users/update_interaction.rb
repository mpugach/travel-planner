module Api
  module V1
    module Users
      class UpdateInteraction < Api::V1::ApplicationInteraction
        integer :id

        hash :data do
          hash :attributes do
            string :email, default: nil
            string :password, default: nil
          end
        end

        def execute
          add_errors(user.errors) unless user.update(permitted_attributes)

          serialize(user)
        end

        private

        def user
          @_user ||= User.find(id)
        end

        def authorized?
          id == current_user.id || current_user.can_manage_users?
        end

        def permitted_attributes
          data['attributes'].compact
        end
      end
    end
  end
end
