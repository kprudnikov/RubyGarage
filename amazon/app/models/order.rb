class Order < ActiveRecord::Base
  has_one :billing_address, class_name: "Address", foreign_key: "billing_address"
  has_one :shippng_address, class_name: "Address", foreign_key: "shipping_address"
end
