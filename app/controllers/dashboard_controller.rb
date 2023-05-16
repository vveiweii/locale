class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    @businesses = @user.businesses
    @business = Business.new
  end
end
