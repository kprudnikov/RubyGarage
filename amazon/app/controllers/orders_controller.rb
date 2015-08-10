class OrdersController < ApplicationController

  before_action :authenticate_customer!

  def index
    @orders = current_customer.orders
  end

  def show
    begin
      @order = Order.find(params[:id])
      if !current_customer.orders.include?( @order )
        flash[:alert] = "Access denied"
        redirect_to order_path(current_customer.order_in_progress)
      end
    rescue
      flash[:alert] = "Order not found"
      redirect_to root_path
    end
  end

  def update

    @order = Order.find(params[:id])
    if !(current_customer.order_in_progress == @order)
      flash[:alert] = "Access denied"
      redirect_to request.referrer
    else
      update_order_params.each do |item|
        @order.order_items.update(item["id"], {id: item["id"], quantity: item["quantity"]})
      end
      if @order.save
        flash[:success] = "Order updated"
      else
        flash[:alert] = "Update failed"
      end
      redirect_to order_path(@order)
    end
  end

  def destroy

    @order = Order.find(params[:id])
    if current_customer.order_in_progress == @order || current_customer.admin?
      if @order.destroy
        flash[:success] = "Cart is cleared"
        redirect_to root_path
      else
        flash[:success] = "Error"
        redirect_to order_path @order
      end
    end
  end

  def checkout_step_1

  end

private

  def create_order_item_params
    params.permit([:book_id, :quantity])
  end

  def update_order_params
    # params.require(:order).permit([:order_items, :id])
    params["order"]["order_items"]
  end

end
