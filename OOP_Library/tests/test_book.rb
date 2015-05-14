require_relative '../book'
require_relative '../author'
require "test/unit"

class TestBooks < Test::Unit::TestCase

  def setup
    @author = Author.new('name', 'Bio', 1)
    @book = Book.new('BookTitle', @author, 2)
  end

  def test_create_book
    assert @book.is_a? Book
  end

  def test_argumets_types
    assert_raise (TypeError){ Book.new(1, @author, 5) }
    assert_raise (TypeError){ Book.new('title', 'test', 2) }
  end

  def test_book_counts_times_taken
    10.times do
      @book.take
    end
    assert_equal 10, @book.times_taken
  end

  def test_to_s
    assert_equal "'BookTitle' by name", @book.to_s
  end
end