module Api
  module V1
    class ApplicationController < ::ApplicationController
      include DeviseTokenAuth::Concerns::SetUserByToken

      before_action :authenticate_api_v1_user!

      rescue_from 'Api::NotAuthorizedError' do
        head :unauthorized
      end

      private

      def render_interaction(
        klass,
        success: ->(int) { render json: int.result },
        failure: ->(int) { render json: int.serialized_errors, location: false, status: :unprocessable_entity }
      )
        interaction = klass.run(params.merge(current_user: current_api_v1_user))

        (interaction.valid? ? success : failure)[interaction]
      end
    end
  end
end
