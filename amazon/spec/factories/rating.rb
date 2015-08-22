FactoryGirl.define do
  factory :rating do
    review Faker::Lorem.paragraph
    rating Faker::Number.digit
    customer
    book
  end
end