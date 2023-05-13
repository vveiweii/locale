class DashboardController < ApplicationController
  def index
    @user = current_user
    @businesses = @user.businesses
  end
end
