# rubocop:disable Metrics/MethodLength
class LineItemsController < ApplicationController
  def create
    chosen_product = Service.find(params[:service_id])
    current_cart = @current_cart

    if current_cart.services.include?(chosen_product)
      @line_item = current_cart.line_items.find_by(service_id: chosen_product)
      @line_item.quantity += 1
    else
      @line_item = LineItem.new
      @line_item.cart = current_cart
      @line_item.service = chosen_product
    end
    @line_item.save
    redirect_to request.referer
  end

  def add_quantity
    @line_item = LineItem.find(params[:id])
    @line_item.quantity += 1
    @line_item.save
    redirect_to cart_path(@current_cart)
  end

  def reduce_quantity
    @line_item = LineItem.find(params[:id])
    @line_item.quantity -= 1 if @line_item.quantity > 1
    @line_item.save
    redirect_to cart_path(@current_cart)
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    redirect_to cart_path(@current_cart)
  end

  private

  def line_item_params
    params.require(:line_item).permit(:quantity, :service_id, :cart_id)
  end
end
# rubocop:enable Metrics/MethodLength
