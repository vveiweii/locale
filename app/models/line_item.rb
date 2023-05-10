class LineItem < ApplicationRecord
  belongs_to :service
  belongs_to :cart
  belongs_to :booking
end
