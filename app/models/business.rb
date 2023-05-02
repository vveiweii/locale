class Business < ApplicationRecord
  belongs_to :user

  has_many :services, dependent: :destroy
end
