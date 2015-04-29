require 'json'
require 'date'
require_relative "author"
require_relative "book"
require_relative "reader"
require_relative "order"

rawdata = JSON.parse(File.read('data/library.json'))
authors = []
books = []
readers = []
orders = []

rawdata["authors"].each do |author|
  authors << Author.new(author["name"], author["biography"], author["id"])
end

rawdata["books"].each do |book|
  author = authors.find{|au| au.id == book['author_id']}
  if author
    books << Book.new(book["title"], author, book["id"])
  end
end

rawdata["readers"].each do |reader|
  readers << Reader.new(reader)
end

rawdata["orders"].each do |order|
  reader = readers.find{|rd| rd.id == order["reader_id"]}
  book = books.find{|bk| bk.id == order["book_id"]}
  reader.take_book(book)
  book.take
  date = DateTime.parse(order["order_date"])
  orders << Order.new(book, reader, date)
end

eager_reader = readers.sort_by{|reader| reader.books_taken}[-1]
popular_book = books.sort_by{|book| book.times_taken}[-1]

puts
puts
puts "The most eager reader is #{eager_reader}, he took #{eager_reader.books_taken} books."
puts "The most popular book is #{popular_book}. It was taken #{popular_book.times_taken} times by these gorgeous people:"
readers.each do |reader|
  if reader.books.include?(popular_book)
    puts reader
  end
end
puts
puts

authors_string  = ""
readers_string = ""
books_string = ""
orders_string = ""

authors.each do |author|
  authors_string << author.stringify
end

readers.each do |reader|
  readers_string << reader.stringify
end

books.each do |book|
  books_string << book.stringify
end

orders.each do |order|
  orders_string << order.stringify
end

file = File.new("data/saved_data.txt", "w")
file.write(authors_string + readers_string + books_string + orders_string)
file.close