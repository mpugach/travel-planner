module Api
  module V1
    module Users
      class IndexInteraction < Api::V1::ApplicationInteraction
        def execute
          serialize(users, is_collection: true)
        end

        private

        def users
          User.where('role <= ?', User.roles[current_user.role]).order(:email)
        end

        def authorized?
          current_user.can_manage_users?
        end
      end
    end
  end
end
