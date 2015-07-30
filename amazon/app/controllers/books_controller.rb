class BooksController < ApplicationController
  before_action :authenticate_customer!, only: [:new, :create]

  def index
    @books = Book.all
    @order_item = OrderItem.new
  end

  def show
    @book = Book.find(params[:id])
    @rating = Rating.new
  end

  def new
    @formatted_categories = Category.all.collect{|category| [category.title, category.id]}
    @formatted_authors = Author.all.collect{|author| [author.firstname+" "+author.lastname, author.id]}
    @book = Book.new
  end

  def create
    @book = Book.create(book_params)
    redirect_to @book
  end

private

  def book_params
    params.require(:book).permit([:title, :description, :price, :in_stock, :author_id, :category_id])
  end

end