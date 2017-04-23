module Api
  module V1
    class UserSerializer < Api::V1::ApplicationSerializer
      attribute :email
    end
  end
end
