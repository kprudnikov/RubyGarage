FactoryGirl.define do
  factory :customer do
    email Faker::Internet.email
    firstname Faker::Name.first_name
    lastname Faker::Name.last_name
    admin false
    billing_address_id nil
    shipping_address_id nil
    encrypted_password "testtest"

  end
end