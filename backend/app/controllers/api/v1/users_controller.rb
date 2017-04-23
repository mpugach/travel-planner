module Api
  module V1
    class UsersController < Api::V1::ApplicationController
      def show
        render_interaction Api::V1::Users::MeInteraction
      end

      def index
        render_interaction Api::V1::Users::IndexInteraction
      end
    end
  end
end
