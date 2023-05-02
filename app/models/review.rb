class Review < ApplicationRecord
  belongs_to :user

  validates :description, presence: true, length: { maximum: 500 }
  validates :rating, numericality: true, presence: true, inclusion: { in: 1..5 }
end
