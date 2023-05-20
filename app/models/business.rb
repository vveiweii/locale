class Business < ApplicationRecord
  belongs_to :user
  has_many :services, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many_attached :photos

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 500 }

  geocoded_by :full_address, latitude: :lat, longitude: :lon
  after_validation :geocode, if :address_changed?

  def full_address
    [address, city, state, "Australia"].compact.join(', ')
  end

  def address_changed?
    address_changed? || city_changed? || postcode_changed? || state_changed?
  end

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [:name, :description],
    associated_against: { services: %i[name description] },
    using: {
      tsearch: { prefix: true }
    }

  def available=(value)
    self[:available] = value == "1" ? "yes" : "no"
  end
end
# end
