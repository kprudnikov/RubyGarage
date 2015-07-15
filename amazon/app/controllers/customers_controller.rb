class CustomersController < ApplicationController

  def index
    @customers = Customer.all
  end

  def login
    @customer = Customer.last
  end

end
