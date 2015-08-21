FactoryGirl.define do
  factory :order do
    total_price nil
    state "in_progress"
    # customer_id nil
    customer
    credit_card_id nil
    billing_address_id nil
    shipping_address_id nil
    delivery_service_id nil
  end
end