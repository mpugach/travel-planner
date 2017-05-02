module Api
  module V1
    module Users
      class UpdateInteraction < Api::V1::Users::CreateInteraction
        include Api::V1::Users::Concerns::Crudable

        private

        def action
          user.update(permitted_attributes)
        end

        def authorized?
          super && current_user.permitted_roles_to_set.include?(permitted_attributes[:role])
        end
      end
    end
  end
end
