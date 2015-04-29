require_relative '../book'
require_relative '../reader'
require "json"
require "test/unit"

class TestReaders < Test::Unit::TestCase

  def setup
    @author = Author.new('AuthorName', "Biography", 2)
    @book = Book.new('BookTitle', @author, 2)
    reader_data = JSON.parse('{"name": "ReaderName", "email": "email", "city": "city", "address": "address", "id": 1}')
    @reader = Reader.new(reader_data)
  end

  def test_to_s
    assert_equal 'ReaderName', @reader.to_s
  end

  def test_default_values
    reader_data = JSON.parse('{"name": "Name"}')
    reader = Reader.new(reader_data)

    assert_equal 'Name', reader.name
    assert_equal '', reader.email
    assert_equal '', reader.city
    assert_equal '', reader.address
    assert_equal 0, reader.house
  end

  def test_initial_books_number
    assert_equal 0, @reader.books_number
  end

  def test_books_calculation
    10.times{@reader.take_book(@book)}
    assert_equal 10, @reader.books_number
  end
end