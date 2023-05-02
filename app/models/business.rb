class Business < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 500 }

  has_many :services, dependent: :destroy
end
