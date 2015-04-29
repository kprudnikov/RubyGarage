require_relative "modules"

class Order
  include Jsonable

  attr_reader :book, :reader

  def initialize(book, reader, date=0)
    @book = book
    @reader = reader
    @date = date || Time.now
  end

  def date
    @date.strftime("%d.%M.%Y")
  end
end