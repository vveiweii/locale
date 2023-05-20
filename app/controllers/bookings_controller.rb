class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookings = current_user.bookings.all.order(created_at: :desc)
    @cart = @current_cart
    @review = Review.new
  end

  def new
    @booking = Booking.new
    @cart = @current_cart
    @business = Business.find(@cart.services.first.business_id)
  end

  # rubocop:disable Metrics/MethodLength
  def create
    @booking = Booking.new(booking_params)
    @booking.user_id = current_user.id
    if @current_cart.line_items.first.present?
      service = @current_cart.line_items.first.service
      @booking.business_id = service.business_id
    end
    if @booking.save
      @current_cart.line_items.each do |item|
        @booking.line_items << item
        item.update(cart_id: nil)
        # item.cart_id = nil
        # item.save
      end
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      redirect_to bookings_path, notice: "Booking was successfully created."
    else
      render :new, status: :unprocessable_entity, alert: "Booking was not created."
    end
  end
  # rubocop:enable Metrics/MethodLength

  def show
    @booking = Booking.find(params[:id])
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to request.referer
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :user_id, :business_id)
  end
end
