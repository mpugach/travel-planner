module Api
  module V1
    class ApplicationController < ::ApplicationController
      include DeviseTokenAuth::Concerns::SetUserByToken

      before_action :authenticate_api_v1_user!

      rescue_from 'Api::NotAuthorizedError' do
        render json: { errors: ['Authorized users only.'] }, status: :unauthorized
      end

      private

      def render_interaction(
        klass,
        success: ->(int) { render json: int.result },
        failure: ->(int) { render json: int.serialized_errors, location: false, status: :unprocessable_entity }
      )
        interaction = klass.run(interaction_params)

        (interaction.valid? ? success : failure)[interaction]
      end

      def interaction_params
        params
          .permit!
          .to_h
          .deep_transform_keys(&:underscore)
          .merge(current_user: current_api_v1_user)
      end
    end
  end
end
