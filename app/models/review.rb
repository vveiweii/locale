class Review < ApplicationRecord
  belongs_to :user

  validates :description, presence: true
  validates :rating, numericality: true, presence: true, inclusion: { in: 1..5 }
end
