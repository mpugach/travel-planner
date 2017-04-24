module Api
  module V1
    class ErrorSerializer
      def self.serialize(errors)
        {
          errors: errors.messages.map do |k, v|
            {
              detail: errors.full_message(k, v.to_sentence),
              source: {
                pointer: "data/attributes/#{k}",
                parameter: k
              }
            }
          end
        }
      end
    end
  end
end
