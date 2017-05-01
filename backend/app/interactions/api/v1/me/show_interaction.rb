module Api
  module V1
    module Me
      class ShowInteraction < Api::V1::ApplicationInteraction
        def execute
          serialize(current_user, serializer: Api::V1::MeSerializer)
        end

        private

        def authorized?
          current_user.present?
        end
      end
    end
  end
end
