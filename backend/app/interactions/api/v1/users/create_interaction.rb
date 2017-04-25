module Api
  module V1
    module Users
      class CreateInteraction < Api::V1::ApplicationInteraction
        ROLE = 'role'.freeze
        ATTRIBUTES = 'attributes'.freeze

        hash :data do
          hash :attributes do
            string :role, default: nil
            string :email, default: nil
            string :password, default: nil
          end
        end

        def execute
          add_errors(user.errors) unless action

          serialize(user)
        end

        private

        def action
          user.password = SecureRandom.hex
          user.save
        end

        def user
          @_user ||= User.new(permitted_attributes)
        end

        def permitted_attributes
          attributes = data[ATTRIBUTES]

          attributes.delete(ROLE) unless current_user.permitted_roles_to_set.include?(attributes[ROLE])

          attributes.compact
        end

        def authorized?
          current_user.can_manage_users?
        end
      end
    end
  end
end
