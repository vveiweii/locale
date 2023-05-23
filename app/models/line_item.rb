class LineItem < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  belongs_to :service, optional: true
  belongs_to :cart, optional: true
  belongs_to :booking, optional: true

  validates :service_id, uniqueness: { scope: :cart_id, message: 'as already been added' }

  def total_price
    self.quantity * self.service.price
  end

  def total_offer
    self.quantity * self.service.offer
  end

  def price_or_offer
    self.service.offer.positive? ? number_to_currency(self.service.offer, unit: "AUD") : number_to_currency(self.service.price, unit: "AUD")
  end
end
