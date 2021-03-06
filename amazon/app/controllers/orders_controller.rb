class OrdersController < ApplicationController

  before_action :authenticate_customer!
  before_action :get_current_order, only: [:show, :update, :destroy]

  def index
    @orders = current_customer.orders.where("state != 'in_progress'")
  end

  def update

    # this part is impossible to test
    update_order_items_params.each do |item|
      @order.order_items.update(item[:id], {quantity: item[:quantity]})
    end

    if @order.save
      flash[:success] = "Order updated"
    else
      flash[:alert] = "Update failed"
    end
    redirect_to order_path(@order)
  end

  def destroy
    if @order.in_progress?
      @order.clear
    end
    flash[:success] = "Cart is cleared"
    redirect_to root_path
  end

# Admin states handle
  def set_state

    if !current_customer.admin?
      flash[:alert] = "Access denied"
      redirect_to request.referrer
      return
    end

    @order = Order.find(params[:order_id])

    begin
      case params[:order][:state]
      when "in_queue"
        @order.place
      when "in_delivery"
        @order.send_order
      when "delivered"
        @order.deliver
      when "canceled"
        @order.cancel
      end
      if @order.save
        flash[:success] = "Order state updated"
      else
        flash[:alert] = "Order state wasn't updated"
      end
    rescue
      flash[:alert] = "Incorrect transition"
    end
    redirect_to request.referrer
  end

  # admin page for managing orders
  def manage
    if current_customer.admin?
      @orders = Order.all
    else
      flash[:alert] = "Access denied"
      redirect_to request.referrer
    end
  end

private

  def create_order_item_params
    params.permit([:book_id, :quantity])
  end

  def update_order_items_params
    params.require(:order).require(:order_items)
  end

  def get_current_order
    @order = Order.find(params[:id])
    if has_access?
      flash[:alert] = "Access denied"
      redirect_to root_path
    end
  end

  def has_access?
    !current_customer.admin? && (@order.state != "in_progress" || !(@order.customer_id == current_customer.id))
  end
end