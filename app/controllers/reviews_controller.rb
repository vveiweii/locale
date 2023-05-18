class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @booking = Booking.find(params["booking_id"])
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.booking_id = params["booking_id"]
    if @review.save
      redirect_to bookings_path, notice: "Review created successfully"
    else
      redirect_to bookings_path, alert: "Review not created"
    end
  end

  private

  def review_params
    params.require(:review).permit(:description, :rating)
  end
end
