class BusinessesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:query].present?
      @businesses = Business.global_search(params[:query])
    else
      @businesses = Business.all
    end
  end

  def new
    @business = Business.new
  end

  def create
    @business = Business.new(business_params)
    @business.user = current_user
    if @business.save
      redirect_to dashboard_index_path, notice: 'Your business was added successfully.'
    else
      redirect_to dashboard_index_path, alert: 'Your business was not added.'
    end
  end

  def show
    @business = Business.find(params[:id])
    @services = @business.services
    @cart = @current_cart
    @reviews = Review.joins(:booking).where(bookings: { business_id: @business.id })
    @reviews_average_rating = @reviews.average(:rating)
    @line_item = @cart.line_items.find_by(service_id: params[:service_id])
  end

  def update
    if @business.update(business_params)
      redirect_to @business, notice: "Business updated successfully!"
    else
      render :edit, alert: "Something went wrong."
    end
  end

  def destroy
    @user = current_user
    business.destroy
    redirect_to @user, notice: "Business deleted successfully!"
  end

  private

  def business_params
    params.require(:business).permit(
      :name, :email,
      :address, :city,
      :state, :postcode,
      :available, :description,
      :user_id, photos: []
    )
  end
end
