class PagesController < ApplicationController
  def home
    @new_businesses = Business.order(created_at: :desc).limit(4).where(available: 'yes')
    @cart = @current_cart
    @new_reviews = Review.order(created_at: :desc).limit(4)
  end
end
