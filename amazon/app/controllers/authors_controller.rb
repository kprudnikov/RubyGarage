class AuthorsController < ApplicationController
  before_action :set_author, only: :show
  before_action :authenticate_customer!, only: [:new, :create, :edit]

  def show
  end

  def edit
    if(!current_customer.admin?)
      flash[:alert] = "Access denied"
    else
      set_author
    end
  end

  def new
    @author = Author.new
  end

  def update
    if(!current_customer.admin?)
      flash[:alert] = "Access denied"
    else
      set_author
      if @author.update(author_params)
        flash[:success] = "Author updated"
      else
        flash[:alert] = "Author wasn't updated"
      end
    end
    redirect_to root_path
  end

  def create
    @author = Author.find_by(author_search_params)
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
    params.require(:author).permit([:firstname, :lastname, :biography])
  end

  def author_search_params
    params.require(:author).permit([:firstname, :lastname])
  end

end