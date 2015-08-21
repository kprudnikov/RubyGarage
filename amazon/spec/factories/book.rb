FactoryGirl.define do
  factory :book do
    title Faker::Commerce.product_name
    price Faker::Commerce.price
    in_stock Faker::Number.number (2)
    author
  end
end