class Trip < ApplicationRecord
  belongs_to :user

  validates :user, :end_date, :start_date, :destination, presence: true

  validate :dates_range

  private

  def dates_range
    return if end_date.blank? || start_date.blank?

    errors.add(:end_date, 'should be bigger or equal to start date') if end_date < start_date
  end
end
