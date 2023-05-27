class BusinessesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_business, only: %i[show update destroy]

  # rubocop:disable Metrics
  def index
    if params[:query].present? && params[:city].present?
      @businesses = Business.global_search(params[:query])
                            .where(available: 'yes')
                            .where(city: params[:city])
    else
      @businesses = Business.all.where(available: 'yes').where(city: params[:city])
    end

    @markers = @businesses.map do |business|
      {
        lat: business.latitude,
        lng: business.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { business: business })
      }
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
    @reviews_average_rating = @reviews.any? ? @reviews.average(:rating) : "No reviews"
    @markers = [{
      lat: @business.latitude,
      lng: @business.longitude,
      info_window_html: render_to_string(partial: "info_window", locals: { business: @business })
    }]
  end
  # rubocop:enable Metrics

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
      :available, :industry,
      :description,
      :user_id, photos: []
    )
  end
end
