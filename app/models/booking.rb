class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :business
  has_many :line_items, dependent: :destroy

  validates_associated :user

  validates :start_date, presence: true
  validates :end_date, comparison: { greater_than: :start_date }
end
