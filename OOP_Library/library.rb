require 'json'
require 'date'
require_relative "author"
require_relative "book"
require_relative "reader"
require_relative "order"

module Lib
  class Library

    def initialize(file='')
      @books = []
      @authors = []
      @readers = []
      @orders = []

      load(file) if file != ''

    end

    def load(path="data/library.json")
      rawdata = JSON.parse(File.read(path))
      load_authors(rawdata["authors"])
      load_books(rawdata["books"])
      load_readers(rawdata["readers"])
      load_orders(rawdata["orders"])
    end

    def frequent_reader(book)
      if(book.is_a? Book)
        return @readers.sort_by{|reader| reader.books_taken}[-1]
      elsif book.is_a? String
        sought_book = find_book_by_title(book)
        frequent_reader(sought_book) if sought_book
      else
        raise TypeError, "book should be a Book or a String"
      end
    end

    def popular_book
      @books.sort_by{|book| book.times_taken}[-1]
    end

    def who_takes_popular_book
      readers = []
      @readers.each do |reader|
        if reader.books.include?(popular_book)
          readers << reader
        end
      end
    end

    def find_book_by_title(name)
      @books.find{|book| book.title == title}
    end

    def add(el)
      case el
      when el.is_a? Book
        @books << el
      when el.is_a? Author
        @authors << el
      when el.is_a? Reader
        @readers << el
      when el.is_a? Order
        @books << el.book if !@books.include(el.book)
        @readers << el.reader if !@readers.include(el.reader)
        @orders << el
      else
        raise TypeError, "wrong type. Only Book, Reader, Author or Order can be added"
      end
    end

  private

    def load_books(books)
      books.each do |book|
        author = @authors.find{|au| au.id == book['author_id']}
        if author
          @books << Book.new(book["title"], author, book["id"])
        end
      end
    end

    def load_authors(authors)
      authors.each do |author|
        @authors << Author.new(author["name"], author["biography"], author["id"])
      end
    end

    def load_readers(readers)
      readers.each do |reader|
        @readers << Reader.new(reader)
      end
    end

    def load_orders(orders)
      orders.each do |order|
        reader = @readers.find{|rd| rd.id == order["reader_id"]}
        book = @books.find{|bk| bk.id == order["book_id"]}
        reader.take_book(book)
        book.take
        date = DateTime.parse(order["order_date"])
        @orders << Order.new(book, reader, date)
      end
    end
  end
end

lib = Lib::Library.new("data/library.json")
puts lib.popular_book
puts lib.who_takes_popular_book
puts lib.frequent_reader(lib.popular_book)