class OrderItemsController < ApplicationController
  before_action :authenticate_customer!, only: [:destroy]

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

end
