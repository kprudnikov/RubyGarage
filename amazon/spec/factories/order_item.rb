FactoryGirl.define do
  factory :order_item do
    quantity 1
    book
    order
  end
end