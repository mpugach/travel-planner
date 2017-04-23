module Api
  module V1
    module Users
      class ShowInteraction < Api::V1::ApplicationInteraction
        integer :id

        def execute
          serialize(User.find(id))
        end

        private

        def authorized?
          id == current_user.id || current_user.can_manage_users?
        end
      end
    end
  end
end
