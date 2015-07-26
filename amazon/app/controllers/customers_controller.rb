class CustomersController < ApplicationController
  before_action :authenticate_customer!

  def index
    @customers = Customer.all
  end

  # def last_order_in_progress
  #   # @customer = Customer.find(params[:id])
  #   # @customer = current_customer
  #   # @customer = Customer.find(1)
  #   # puts
  #   @order = Order.last_in_progress(current_customer) || Order.new
  # end


end