class Business < ApplicationRecord
  belongs_to :user
  has_many :services, dependent: :destroy
  has_many :bookings, dependent: :destroy
  #has_many :reviews, dependent: :destroy
  has_many_attached :photos
  geocoded_by :full_address
  after_validation :geocode, if :will_save_change_to_address?

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 500 }
  attribute :available, :string, default: 'yes'

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [:name, :description],
    associated_against: { services: %i[name description] },
    using: {
      tsearch: { prefix: true }
    }

end
end
