class CategoriesController < ApplicationController
  before_action :authenticate_customer!, only: [:new, :create]

  def new
    @category = Category.new
  end

  def create
    @category = Category.find_by(create_category_params)
    if (@category)
      flash[:alert] = "Category exists"
      redirect_to new_category_path
    else
      @category = Category.new(create_category_params)
      if(@category.save)
        flash[:success] = "Category added"
        redirect_to root_path
      else
        flash[:alert] = "Error"
        redirect_to new_category_path
      end
    end
  end

  def show
    @category = Category.find(params[:id])
    @order_item = OrderItem.new
    @books = @category.books
    render template: "books/index"
  end

  def index
    @categories = Category.all
  end

private

  def create_category_params
    params.require(:category).permit(:title)
  end

end