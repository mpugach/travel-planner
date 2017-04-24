module Api
  module V1
    module Users
      class UpdateInteraction < Api::V1::ApplicationInteraction
        include Api::V1::Users::Concerns::Crudable

        ROLE = 'role'.freeze
        ATTRIBUTES = 'attributes'.freeze

        integer :id

        hash :data do
          hash :attributes do
            string :role, default: nil
            string :email, default: nil
            string :password, default: nil
          end
        end

        def execute
          add_errors(user.errors) unless user.update(permitted_attributes)

          serialize(user)
        end

        private

        def permitted_attributes
          attributes = data[ATTRIBUTES]

          attributes.delete(ROLE) unless current_user.permitted_roles_to_set.include?(attributes[ROLE])

          attributes.compact
        end
      end
    end
  end
end
