module Api
  module V1
    class MeSerializer < Api::V1::UserSerializer
      def id
        :me
      end
    end
  end
end
