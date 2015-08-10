class Order < ActiveRecord::Base
  belongs_to :billing_address, class_name: "Address"
  belongs_to :shipping_address, class_name: "Address"
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  has_many :books, through: :order_items
  validates :customer, presence: true

  # belongs_to :customer
  # belongs_to :shipping_address, class_name: "Address"
  # belongs_to :billing_address, class_name: "Address"

  include AASM

  aasm column: 'state' do
    state :in_progress, initial: true
    state :in_queue
    state :in_delivery
    state :delivered
    state :canceled
  end

  def add_book(params)
    self.order_items << OrderItem.new(params)
  end

  def self.last_in_progress(customer)
    customer.orders.find_by(state: "in_progress")
  end

  def get_total_price
    self.order_items.inject(0){|sum, item| sum + item.book.price * item.quantity}
  end

end