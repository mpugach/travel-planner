module Api
  module V1
    class UserSerializer < Api::V1::ApplicationSerializer
      attributes :email, :role
    end
  end
end
