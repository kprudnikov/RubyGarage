class AuthorsController < ApplicationController
  before_action :set_author, only: :show
  before_action :authenticate_customer!, only: [:new, :create]

  def show
  end

  def edit
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.find_by(author_params)
    if (@author)
      flash[:alert] = "Author exists"
      redirect_to new_author_path
    else
      @author = Author.new(author_params)
      if @author.save
        flash[:success] = "Author is created"
        redirect_to root_path
      else
        redirect_to new_author_path
        flash[:alert] = "Creation failed"
      end
    end
  end

private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit([:firstname, :lastname])
  end

end