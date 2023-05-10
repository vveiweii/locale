class LineItem < ApplicationRecord
  belongs_to :service
  belongs_to :cart
  belongs_to :booking

  def total_price
    self.quantity * self.service.price
  end

  def taxes
    self.service.price * 0.1
  end
end
