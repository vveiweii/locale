class LineItem < ApplicationRecord
  belongs_to :service, optional: true
  belongs_to :cart, optional: true
  belongs_to :booking, optional: true

  def total_price
    self.quantity * self.service.price
  end

  def taxes
    self.service.price * 0.1
  end
end
