module Api
  module V1
    class ApplicationInteraction < ::ApplicationInteraction
      object :current_user, default: nil, class: :User

      def serialized_errors
        Api::V1::ErrorSerializer.serialize(errors)
      end

      private

      def add_errors(model_errors)
        model_errors.each do |k, v|
          errors.add(k, v)
        end
      end

      def serialize(object, options = {})
        JSONAPI::Serializer.serialize(object, options.merge(namespace: Api::V1))
      end
    end
  end
end
