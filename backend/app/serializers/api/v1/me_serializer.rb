module Api
  module V1
    class MeSerializer < Api::V1::UserSerializer
      attribute :permitted_roles_to_set

      attribute :can_manage_users do
        object.can_manage_users?
      end

      def id
        :me
      end
    end
  end
end
