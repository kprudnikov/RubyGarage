require "rails_helper"

describe Customer do

  let(:customer){create(:customer)}

  it "creates new order after being created" do
    expect(customer.orders).not_to be(nil)
    expect(customer.orders.length).to eq(1)
  end

  it "removes all orders when deleted" do
    orders = create_list(:order, 5, customer: customer, state: "delivered")
    customer.destroy
    expect(Order.all.length).to eq(0)
  end

  it "removes all his ratings when deleted" do
    ratings = create_list(:rating, 5, customer: customer)
    customer.destroy
    expect(Rating.all.length).to eq(0)
  end
end