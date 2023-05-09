class BusinessesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    if params[:query].present?
      @businesses = Business.global_search(params[:query])
    else
      @businesses = Business.all
    end
  end

  def new
    @business = current_user.businesses.new
  end

  def create
    @business = current_user.businesses.new(business_params)
    if @business.save
      redirect_to @business, notice: "Business created successfully!"
    else
      render :new
    end
  end

  def show
    @business = Business.find(params[:id])
    @services = @business.services
  end

  def update
    if @business.update(business_params)
      redirect_to @business, notice: "Business updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    @user = current_user
    business.destroy
    redirect_to @user, notice: "Business deleted successfully!"
  end

  private

  def business_params
    params.require(:business).permit(:name, :email, :address, :city, :state, :postcode, :available, :description)
  end
end
