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
    @user = current_user
    @business = @user.business.new
  end

  def create
    @user = current_user
    @business = @user.business.new(business_params)
    if @business.save
      redirect_to @business, notice: "Business created successfully!"
    else
      render :new
    end
  end

  def show
    # set_business
    @business = Business.find(params[:id])
    @services = @business.services
  end

  def update
    # set_business
    if @business.update(business_params)
      redirect_to @business, notice: "Business updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    @user = current_user
    # set_business
    business.destroy
    redirect_to @user, notice: "Business deleted successfully!"
  end

  def search
  end

  private

  def business_params
    params.require(:business).permit(:name, :email, :address, :city, :state, :postcode, :available, :user_id, :description)
  end

  def set_business
    @business = Business.find(params[:id])
  end
end
