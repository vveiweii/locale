class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = @current_cart
    if @cart.services.first.present?
      @business = Business.find(@cart.services.first.business_id)
    else
      @business = nil
    end
  end

  def destroy
    @cart = @current_cart
    @cart.destroy
    session[:cart_id] = nil
    redirect_to root_path
  end
end
