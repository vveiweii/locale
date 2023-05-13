class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookings = current_user.bookings.all
    @cart = @current_cart
  end

  def new
    @booking = Booking.new
    @cart = @current_cart
  end

  # rubocop:disable Metrics/MethodLength
  def create
    @booking = Booking.new(booking_params)
    @booking.user_id = current_user.id
    @current_cart.line_items.each do |item|
      @booking.line_items << item
      item.update(cart_id: nil)
      # item.cart_id = nil
      # item.save
    end

    if @booking.save
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      redirect_to root_path, notice: "Booking was successfully created."
    else
      render :new, status: :unprocessable_entity, notice: "Something went wrong."
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
    params.require(:booking).permit(:start_date, :user_id)
  end
end
