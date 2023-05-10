class Service < ApplicationRecord
  belongs_to :business
  has_many :line_items, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true
  validates :offer, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :available, presence: true, inclusion: { in: %w[yes no], message: "must be 'yes' or 'no'" }
end
