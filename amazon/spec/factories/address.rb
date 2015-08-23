FactoryGirl.define do
  factory :address do
    address Faker::Address.street_name
    zipcode Faker::Address.zip
    city Faker::Address.city
    phone Faker::PhoneNumber.phone_number
    country_id 1
    firstname Faker::Name.first_name
    lastname Faker::Name.last_name 
  end
end