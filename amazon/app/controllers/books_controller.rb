class BooksController < ApplicationController
  before_action :authenticate_customer!, only: [:new, :create, :edit, :update]
  before_action :format_authors_and_categories, only: [:new, :edit]

  def index
    @books = Book.all
    @order_item = OrderItem.new
  end

  def show
    @book = Book.find(params[:id])
    @order_item = OrderItem.new
    @rating = Rating.new
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.create(book_params)
    redirect_to @book
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.update!(book_params)
    redirect_to book_path @book
  end

private

  def book_params
    params.require(:book).permit([:title, :description, :price, :in_stock, :author_id, :category_id, :cover])
  end

  def format_authors_and_categories
    @formatted_categories = Category.all.collect{|category| [category.title, category.id]}
    @formatted_authors = Author.all.collect{|author| [author.firstname+" "+author.lastname, author.id]}
  end

end