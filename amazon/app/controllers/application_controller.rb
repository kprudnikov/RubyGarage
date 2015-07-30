class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :create_empty_order

  def initialize
    @categories = Category.all
    super
  end

private

  def create_empty_order
    if current_customer && !current_customer.order_in_progress
      Order.create(customer_id: current_customer.id)
    end
  end

end
