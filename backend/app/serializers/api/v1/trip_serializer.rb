module Api
  module V1
    class TripSerializer < Api::V1::ApplicationSerializer
      include ActionView::Helpers::SanitizeHelper

      attributes :user_id, :end_date, :start_date, :destination

      has_one :user

      attribute :comment do
        sanitize object.comment
      end
    end
  end
end
