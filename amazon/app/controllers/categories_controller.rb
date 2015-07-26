class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.find_by(category_params)
    if (@category)
      flash[:alert] = "Category exists"
      redirect_to new_category_path
    else
      @category = Category.new(category_params)
      if(@category.save)
        flash[:success] = "Category added"
      else
        flash[:alert] = "Error"
      end
      redirect_to root_path
    end
  end

private

  def category_params
    params.require(:category).permit(:title)
  end

end