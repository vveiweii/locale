class BizdashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    @business = Business.find(params[:business])
    @service = Service.new
    @services = @business.services
    @bookings = @business.bookings
  end
end
