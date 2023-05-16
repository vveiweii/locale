class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :services, through: :line_items

  def sub_total
    sum = 0
    self.line_items.each do |line_item|
      line_item.service.offer.positive? ? sum += line_item.total_offer : sum += line_item.total_price
    end
    return sum
  end

  def taxes
    sub_total * 0.1
  end
end
