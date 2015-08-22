FactoryGirl.define do
  factory :order do
    total_price nil
    state "in_progress"
    customer
    delivery_service
  end
end