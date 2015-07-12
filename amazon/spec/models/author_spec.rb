require 'rails_helper'

describe Author do

  let (:author) {FactoryGirl.create :author}
  let (:book) {FactoryGirl.create :book}

  it "stores all added books" do
    books = []
    books.push(FactoryGirl.create :book, author: author)
    expect(author.books.length).to eq(books.length)
  end


end