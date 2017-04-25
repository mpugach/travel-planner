module Api
  module V1
    module Users
      class ShowInteraction < Api::V1::ApplicationInteraction
        include Api::V1::Users::Concerns::Crudable

        def execute
          serialize(user)
        end
      end
    end
  end
end
