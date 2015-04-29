require_relative "modules"

class Reader
  include Jsonable

  attr_accessor :name, :email, :city, :address, :house, :books, :books_taken
  attr_reader :id

  def initialize(data)
    @name = data["name"]
    @email = data["email"] || ""
    @city = data["city"] || ""
    @address = data["address"] || ""
    @house = data["house"] || 0
    @books_taken = 0
    @books = []
    @id = data["id"] || self.object_id
  end

  def to_s
    @name
  end

  def take_book(book)
    raise TypeError, 'Should be a Book' unless book.is_a? Book
    @books << book
    @books_taken += 1
  end

end