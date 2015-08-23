FactoryGirl.define do
  factory :customer do
    email {Faker::Internet.email}
    firstname Faker::Name.first_name
    lastname Faker::Name.last_name
    admin false
    billing_address_id nil
    shipping_address_id nil
    password "testtest"
    password_confirmation "testtest"
  end

  factory :other_customer do
    email Faker::Internet.email("other")
    firstname Faker::Name.first_name
    lastname Faker::Name.last_name
    admin false
    billing_address_id nil
    shipping_address_id nil
    password "testtest"
    password_confirmation "testtest"
  end

  factory :admin, class: "Customer" do
    email Faker::Internet.email("admin")
    firstname Faker::Name.first_name
    lastname Faker::Name.last_name
    admin true
    billing_address_id nil
    shipping_address_id nil
    password "testtest"
    password_confirmation "testtest"
  end

end