module Api
  module V1
    module Me
      class UpdateInteraction < Api::V1::ApplicationInteraction
        hash :data do
          hash :attributes do
            string :email, default: nil
            string :password, default: nil
          end
        end

        def execute
          add_errors(user.errors) unless action

          serialize(user, serializer: Api::V1::MeSerializer)
        end

        private

        def action
          user.update(permitted_attributes)
        end

        def user
          current_user
        end

        def permitted_attributes
          data[:attributes].compact
        end

        def authorized?
          current_user.present?
        end
      end
    end
  end
end
