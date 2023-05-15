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
      redirect_to dashboard_index_path, notice: "Review created successfully"
    else
      redirect_to dashboard_index_path, notice: "Review not created"
    end
  end

  def destroy
    @review = @list.reviews.find(params[:id])
    @review.destroy
    redirect_to list_path(@list)
  end

  private

  def review_params
    params.require(:review).permit(:description, :rating)
  end
end
