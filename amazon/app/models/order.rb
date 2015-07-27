class Order < ActiveRecord::Base
  belongs_to :billing_address, class_name: "Address", foreign_key: "billing_address"
  belongs_to :shipping_address, class_name: "Address", foreign_key: "shipping_address"
  belongs_to :customer
  has_many :order_items
  has_many :books, through: :order_items
  validates :customer, presence: true

  def add_book(params)
    self.order_items << OrderItem.new(params)
  end

  def self.last_in_progress(customer)
    customer.orders.find_by(state: "in progress")
  end

  def get_total_price
    self.order_items.inject(0){|sum, item| sum + item.book.price * item.quantity}
  end

end
