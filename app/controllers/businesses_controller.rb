class BusinessesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_business, only: %i[show edit update destroy]

  def index
    if params[:query].present?
      @businesses = Business.global_search(params[:query]).where(available: 'yes')

      @markers = @businesses.geocoded.map do |business|
        {
          lat: business.latitude,
          lng: business.longitude,
          info_window_html: render_to_string(partial: "info_window", locals: { business: business })
        }
      end
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
    @services = @business.services
    @cart = @current_cart
    @reviews = Review.joins(:booking).where(bookings: { business_id: @business.id })
    @reviews_average_rating = @reviews.average(:rating)
    # @line_item = @cart.line_items.find_by(service_id: params[:service_id])
    @markers = @busines.geocoded.map do |business|
      {
        lat: business.latitude,
        lng: business.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { business: business })
      }
    end
    raise
    @markers = @business.geocode
    # @markers[:lat] = @business.geocode[0]
    # @markers[:lng] = @business.geocode[1]
  end

  def edit

  end

  def update
    if @business.update(business_params)
      redirect_to request.referer, notice: "Business updated successfully!"
    else
      render request.referer, alert: "Something went wrong."
    end
  end

  def destroy
    @user = current_user
    business.destroy
    redirect_to @user, notice: "Business deleted successfully!"
  end

  private

  def set_business
    @business = Business.find(params[:id])
  end

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
