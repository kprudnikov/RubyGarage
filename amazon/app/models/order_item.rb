class OrderItem < ActiveRecord::Base
  belongs_to :book
  belongs_to :order
  # has_one :book
end
