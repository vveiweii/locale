class ApplicationController < ActionController::Base
  # before_action :authenticate_user!, :configure_permitted_parameters, if: :devise_controller?, except: [:home, :about, :index, :show]
  before_action :authenticate_user!, only: %i[new create], if: -> { params[:business_id].present? }
  # before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  before_action :current_cart

  private

  def current_cart
    if session[:cart_id]
      cart = Cart.find_by(id: session[:cart_id])
      cart.present? ? @current_cart = cart : session[:cart_id] = nil
    end
    if session[:cart_id].nil?
      @current_cart = Cart.create
      session[:cart_id] = @current_cart.id
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password)}

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password)}
  end
end
