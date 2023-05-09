class Business < ApplicationRecord
  belongs_to :user
  has_many :services, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 500 }

  scope :newest, -> { order(created_at: :desc) }

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [:name, :description],
    associated_against: { services: %i[name description] },
    using: {
      tsearch: { prefix: true }
    }
end
