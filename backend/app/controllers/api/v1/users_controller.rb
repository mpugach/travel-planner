module Api
  module V1
    class UsersController < Api::V1::ApplicationController
      def show
        render_interaction Api::V1::Users::MeInteraction
      end
    end
  end
end
