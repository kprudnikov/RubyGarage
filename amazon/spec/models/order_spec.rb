require 'rails_helper'

describe Order, type: :model do

  let (:oi) {FactoryGirl.create :order_item}
  let (:order) {oi.order}

  before do
    order.order_items.update(oi.id, {book_id: oi.book.id, quantity: oi.quantity})
  end

  it "returns total number of books" do
    expect(order.total_number_of_books).to eq(oi.quantity)
  end

  it "calculates total price on update", :focus do
    # should be BigDecimal instead of Float here
    expect(order.total_price.round(2)).to eq(oi.price*oi.quantity+order.delivery_service.cost)
  end

  it "removes all order items when destroyed" do
    expect(order.order_items.all.length).to eq(OrderItem.all.length)
    order.destroy
    expect(OrderItem.all.length).to eq(0)
  end

  it "doesn't remove books when destroyed" do
    books = order.books.length
    order.destroy
    expect(books).to eq(Book.all.length)
  end

  it "changes 'completed_date' when order is delivered" do
    order.state = "in_delivery"
    expect(order.completed_date).to be nil
    order.deliver
    expect(order.completed_date).not_to be nil
  end

  describe "creates new order for it's customer" do
      
    let (:customer){order.customer}

    it "when canceled" do
      order.cancel
      expect(customer.orders).not_to be(nil)
    end

    it "when placed" do
      order.place
      expect(customer.orders).not_to be(nil)
    end
  end

end