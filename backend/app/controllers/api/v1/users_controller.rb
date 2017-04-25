module Api
  module V1
    class UsersController < Api::V1::ApplicationController
      ME = 'me'.freeze

      def show
        render_interaction params[:id] == ME ? Api::V1::Users::MeInteraction : Api::V1::Users::ShowInteraction
      end

      def index
        render_interaction Api::V1::Users::IndexInteraction
      end

      def create
        render_interaction Api::V1::Users::CreateInteraction
      end

      def update
        render_interaction Api::V1::Users::UpdateInteraction
      end

      def destroy
        render_interaction Api::V1::Users::DestroyInteraction
      end
    end
  end
end
