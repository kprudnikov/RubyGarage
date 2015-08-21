FactoryGirl.define do
  factory :rating do
    review Faker::Lorem.paragraph
    rating Faker::Number.digit
    customer_id nil
    book_id nil
  end
end