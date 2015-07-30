class OrdersController < ApplicationController

  before_action :authenticate_customer!

  def index
    @orders = current_customer.orders
  end

  def show
    @order = current_customer.order_in_progress
  end

  def update
    @order = Order.find(params[:id])
    if !(current_customer.order_in_progress == @order)
      flash[:alert] = "Access denied"
      redirect_to request.referrer
    else
      if Book.find(params[:book_id]).in_stock?
        @order.add_book(order_params)
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

  def order_params
    params.permit([:book_id, :quantity])
  end

end
