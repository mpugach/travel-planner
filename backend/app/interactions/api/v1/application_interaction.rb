module Api
  module V1
    class ApplicationInteraction < ::ApplicationInteraction
      object :current_user, default: nil, class: :User

      private

      def serialize(object, options = {})
        JSONAPI::Serializer.serialize(object, options.merge(namespace: Api::V1))
      end
    end
  end
end
