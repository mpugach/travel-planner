class Trip < ApplicationRecord
  belongs_to :user

  validates :user, :destination, presence: true
end
