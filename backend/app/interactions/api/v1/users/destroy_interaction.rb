module Api
  module V1
    module Users
      class DestroyInteraction < Api::V1::ApplicationInteraction
        include Api::V1::Users::Concerns::Crudable

        def execute
          user.destroy

          serialize(user)
        end
      end
    end
  end
end
