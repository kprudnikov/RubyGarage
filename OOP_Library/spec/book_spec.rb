require_relative '../book'
require_relative '../author'

describe Lib::Book do

  before :each do
    @author = Lib::Author.new('name', 'Bio', 1)
    @book = Lib::Book.new('BookTitle', @author, 2)
  end

  it "should be an instance of a Book" do
    expect(@book).to be_a Lib::Book
  end

  it "should raise TypeError if arguments have wrong types" do
    expect{Lib::Book.new(1, @author, 5)}.to raise_error(TypeError)
    expect{Lib::Book.new('title', 'test', 2)}.to raise_error(TypeError)
  end

  it "should count how many times a book was taken" do
    10.times do
      @book.take
    end
    expect(@book.times_taken).to equal(10)
  end

  it "should display author and title when converted to string" do
    expect(@book.to_s).to eql("'BookTitle' by name")
  end
end