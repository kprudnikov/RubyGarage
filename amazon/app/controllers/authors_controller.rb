class AuthorsController < ApplicationController

  # def index
  #   @customers = Customer.all
  # end

  # def login
  #   @customer = Customer.last
  # end

  def show
    @author = Author.find(params[:id])
  end

private

  # def author_

end
