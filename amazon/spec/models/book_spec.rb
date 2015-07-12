require 'rails_helper'

describe Book do

  let (:author) {FactoryGirl.create :author}
  let (:book) {FactoryGirl.create :book, author: author}

  it 'is invalid without title' do
    expect(FactoryGirl.build(:book, title: nil)).not_to be_valid
  end

  it 'is invalid without price' do
    expect(FactoryGirl.build(:book, price: nil)).not_to be_valid
  end

  it 'is invalid without number of books in stock' do
    expect(FactoryGirl.build(:book, in_stock: nil)).not_to be_valid
  end

  it 'is valid when all fields are filled in' do
    expect(book).to be_valid
  end

  it 'has many ratings' do
    expect(book).to respond_to(:ratings)
  end

  it 'has author' do
    expect(book).to respond_to(:author)
  end

  it 'returns author' do
    expect(book.author).to eq(author)
  end
end