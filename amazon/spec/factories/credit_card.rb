FactoryGirl.define do
  factory :credit_card do
    number Faker::Number.number(16)
    cvv Faker::Number.number(3)
    exp_month Faker::Number.number(2)
    exp_year Faker::Number.number(4)
    firstname Faker::Name.first_name
    lastname Faker::Name.last_name
  end
end