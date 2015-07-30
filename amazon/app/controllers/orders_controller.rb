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
      if Book.find(params[:book_id]).in_stock?
        @order.add_book(create_order_item_params)
        if @order.save
          flash[:success] = "Book added"
        else
          flash[:alert] = "Error"
        end
      else
        flash[:alert] = "Book is out of stock"
      end
      redirect_to root_path
    end
  end

private

  def create_order_item_params
    params.permit([:book_id, :quantity])
  end

end
