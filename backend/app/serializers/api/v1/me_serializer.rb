module Api
  module V1
    class MeSerializer < Api::V1::UserSerializer
      def id
        :me
      end

      attribute :can_manage_users do
        object.can_manage_users?
      end
    end
  end
end
