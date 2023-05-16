class Business < ApplicationRecord
  belongs_to :user
  has_many :services, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many_attached :photos

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 500 }
  attribute :available, :string, default: 'no'

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [:name, :description],
    associated_against: { services: %i[name description] },
    using: {
      tsearch: { prefix: true }
    }
end
