module Api
  module V1
    module Users
      class IndexInteraction < Api::V1::ApplicationInteraction
        def execute
          serialize(User.order(:email), is_collection: true)
        end

        private

        def authorized?
          current_user.can_manage_users?
        end
      end
    end
  end
end
