class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def new
    @user = User.find(params[:user_id])
    @booking = @user.bookings.new
  end

  # rubocop:disable Metrics/MethodLength
  def create
    @booking = Booking.new(booking_params)

    @current_cart.line_items.each do |item|
      @booking.line_items << item
      item.update(cart_id: nil)
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
    params.require(:booking).permit(:startdate, :enddate, :status)
  end
end
