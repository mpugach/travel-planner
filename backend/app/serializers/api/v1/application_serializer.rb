module Api
  module V1
    class ApplicationSerializer < ::ApplicationSerializer
      private

      def base_url
        '/api/v1'
      end
    end
  end
end
