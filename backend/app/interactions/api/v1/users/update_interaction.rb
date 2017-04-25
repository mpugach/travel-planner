module Api
  module V1
    module Users
      class UpdateInteraction < Api::V1::Users::CreateInteraction
        include Api::V1::Users::Concerns::Crudable

        private

        def action
          user.update(permitted_attributes)
        end
      end
    end
  end
end
