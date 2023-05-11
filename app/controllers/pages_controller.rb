class PagesController < ApplicationController
  def home
    @new_businesses = Business.order(created_at: :desc).limit(8).where(available: 'yes')
    @cart = @current_cart
  end
end
