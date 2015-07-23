class OrdersController < ApplicationController

  before_action :authenticate_customer!

  def index
    @orders = Order.all
  end

  def show
    @order = current_customer.order_in_progress
  end
end
