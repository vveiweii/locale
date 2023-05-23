class Business < ApplicationRecord
  belongs_to :user
  has_many :services, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many_attached :photos

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :industry, presence: true, format: { with: /\A\w+\z/, message: "Should be a single word" }

  geocoded_by :full_address, latitude: :lat, longitude: :lon
  after_validation :geocode, if :address_changed?

  def full_address
    [address, city, state, "Australia"].compact.join(', ')
  end

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [:name, :description, :industry],
    associated_against: { services: %i[name description] },
    using: {
      tsearch: { prefix: true }
    }

  def available=(value)
    self[:available] = value == "1" ? "yes" : "no"
  end
end
# end
