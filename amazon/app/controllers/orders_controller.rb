class OrdersController < ApplicationController

  before_action :authenticate_customer!

  def index
    @orders = Order.all
  end

  def show
    @order = current_customer.order_in_progress
  end

  def update
    @order = Order.find(params[:id])
    @order.add_book(order_params)
    if @order.save
      flash[:success] = "Book added"
    else
      flash[:alert] = "Error"
    end
    redirect_to root_path
  end

private

  def order_params
    params.permit([:book_id, :quantity])
  end

end
