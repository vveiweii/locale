class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def new
    @user = User.find(params[:user_id])
    @booking = @user.bookings.new(user_id: current_user.id)
  end

  # def new
  #   @booking = current_user.bookings.build
  # end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = User.find(params[:user_id])
    @booking.user = current_user
    if @booking.save
      redirect_to user_path(current_user), notice: "Booking was successfully created."
    else
      render :new, status: :unprocessable_entity, notice: "Something went wrong."
    end
  end

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
    params.require(:booking).permit(:startdate, :enddate)
  end

end
