class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @list = List.find(params[:list_id])
    @review = @list.reviews.new(review_params)
    if @review.save
      redirect_to list_path(@list)
    else
      render "show"
    end
  end

  def destroy
    @list = List.find(params[:list_id])
    @review = @list.reviews.find(params[:id])
    @review.destroy
    redirect_to list_path(@list)
  end

  private

  def review_params
    params.require(:review).permit(:description, :rating)
  end
end
