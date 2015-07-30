class OrderItemsController < ApplicationController
  before_action :authenticate_customer!, only: [:destroy]

  def create
    @order_item = OrderItem.new(order_item_params)
    if @order_item.save
      flash[:success] = "Order Item created"
    else
      flash[:alert] = "Error"
    end
    redirect_to request.referrer
  end

  def destroy
    item = OrderItem.find(params[:id])
    if current_customer.order_in_progress.order_items.include? item
      item.delete
      flash[:success] = "Successfully removed"
    else
      flash[:alert] = "Access denied"
    end
      redirect_to order_path(current_customer.order_in_progress)
  end

private

  def order_item_params
    params.require(:order_item).permit([:order_id, :book_id])
  end

end
