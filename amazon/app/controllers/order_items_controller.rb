class OrderItemsController < ApplicationController
  before_action :authenticate_customer!

  def create
    begin
      @order = current_customer.order_in_progress
      @order_item = @order.order_items.find_by(book_id: create_order_item_params["book_id"].to_i)
      @order_item.quantity += create_order_item_params["quantity"].to_i
    rescue
      @order_item = OrderItem.new(create_order_item_params)
    end
    if @order_item.save
      flash[:success] = "Added to cart"
    else
      flash[:alert] = "Error"
    end

    redirect_to request.referrer
  end

  def destroy


    item = OrderItem.find(params[:id])
    if current_customer.orders.find(params[:order_id]).order_items.include? item
      item.delete
      flash[:success] = "Successfully removed"
    else
      flash[:alert] = "Access denied"
    end
    redirect_to order_path(current_customer.order_in_progress)
  end

  def update
    @order_item = OrderItem.find(params[:id])
    if params.require(:order_item)[:quantity].to_i <= 0
      flash[:alert] = "You cannot order less than 1 book"
    else
      if @order_item.update!(create_order_item_params)
        flash[:success] = "Order successfully updated"
      end
      redirect_to order_path(@order_item.order)
    end
  end

private

  def create_order_item_params
    params.require(:order_item).permit([:order_id, :book_id, :quantity])
  end

end
