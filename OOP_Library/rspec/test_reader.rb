require_relative '../book'
require_relative '../reader'
require "json"

describe Lib::Reader do

  before :each do
    @author = Lib::Author.new('AuthorName', "Biography", 2)
    @book = Lib::Book.new('BookTitle', @author, 2)
    reader_data = JSON.parse('{"name": "ReaderName", "email": "email", "city": "city", "address": "address", "id": 1}')
    @reader = Lib::Reader.new(reader_data)
  end

  it "should convert to string correctly" do
    expect(@reader.to_s).to eql('ReaderName')
  end

  it "should apply default values" do
    reader_data = JSON.parse('{"name": "Name"}')
    reader = Lib::Reader.new(reader_data)

    expect('Name').to eql(reader.name)
    expect('').to eql(reader.email)
    expect('').to eql(reader.city)
    expect('').to eql(reader.address)
    expect(0).to eql(reader.house)
  end

  it "should set initial books number to 0" do
    expect(@reader.books_taken).to eql(0)
  end

  it "should count number of books taken" do
    10.times{@reader.take_book(@book)}
    expect(@reader.books_taken).to eql(10)
  end
end