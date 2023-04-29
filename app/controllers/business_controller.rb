class BusinessController < ApplicationController

  def index
    @businesses = Business.all
  end

  def new
    @business = Business.new
  end

  def create
    @business = Business.new(business_params)
    if @business.save
      redirect_to @business
    else
      render :new
    end
  end

  def show
    # set_business
  end

  def edit
    # set_business
  end

  def update
    # set_business
    business.update(business_params)
    redirect_to business
  end

  def destroy
    # set_business
    business.destroy
    redirect_to businesses_path
  end

  private

  def business_params
    params.require(:business).permit(:name, :email, :address, :city, :state, :postcode, :available, :user_id)
  end

  def set_business
    @business = Business.find(params[:id])
  end
end
