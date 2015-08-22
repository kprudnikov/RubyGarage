FactoryGirl.define do
  factory :delivery_service do
    title Faker::Company.name
    cost Faker::Commerce.price
  end
end