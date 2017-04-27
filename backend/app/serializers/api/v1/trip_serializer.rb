module Api
  module V1
    class TripSerializer < Api::V1::ApplicationSerializer
      attributes :user_id, :end_date, :start_date, :comment, :destination

      has_one :user
    end
  end
end
