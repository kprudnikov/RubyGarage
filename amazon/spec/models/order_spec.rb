require 'rails_helper'

describe Order, type: :model do

  let (:author) {FactoryGirl.create :author}
  let (:book) {FactoryGirl.create :book}
  # let (:customer) {FactoryGirl.create :customer}

  it "adds books" do
    order = FactoryGirl.create(:order)
    order.add_book(book)
    expect(order.books.last).to eq(book)
  end

  it "returns total number of books" do

  end

  it "calculates total price"
  it "removes all books when destroyed"
  it "changes state from 'in_progress' to 'in_queue'"

end