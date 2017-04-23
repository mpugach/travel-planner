module Api
  module V1
    module Users
      class MeInteraction < Api::V1::ApplicationInteraction
        string :id

        def execute
          serialize(current_user, serializer: Api::V1::MeSerializer)
        end

        private

        def authorized?
          true
        end
      end
    end
  end
end
