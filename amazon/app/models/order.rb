class Order < ActiveRecord::Base
  belongs_to :billing_address, class_name: "Address", dependent: :destroy
  belongs_to :shipping_address, class_name: "Address", dependent: :destroy
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  has_many :books, through: :order_items
  validates :customer, presence: true
  belongs_to :delivery_service
  belongs_to :credit_card, dependent: :destroy

  include AASM

  STATES = {
    :in_progress => "In progress",
    :in_queue => "In queue",
    :in_delivery => "In delivery",
    :delivered => "Delivered",
    :canceled => "Canceled"
  }

  aasm column: 'state' do
    state :in_progress, initial: true
    state :in_queue
    state :in_delivery
    state :delivered
    state :canceled

    event :edit do
      transitions from: :in_queue, to: :in_progress
    end

    event :place do
      transitions from: :in_progress, to: :in_queue
    end

    event :send_order do
      transitions from: :in_queue, to: :in_delivery
    end

    event :deliver, after: :deliver_order do
      transitions from: :in_delivery, to: :delivered
    end

    event :cancel do
      transitions from: [:in_queue, :in_delivery], to: :canceled
    end
  end

  def add_book(params)
    self.order_items << OrderItem.new(params)
  end

  def in_progress?
    self.state == "in_progress"
  end

  def self.last_in_progress(customer)
    customer.orders.find_by(state: "in_progress")
  end

  def deliver_order
    self.completed_date = Time.now
  end

  def calculate_total_price
    self.total_price = self.order_items.inject(0){|sum, item| sum + item.book.price*item.quantity}
    if self.delivery_service
      self.total_price += self.delivery_service.cost
    end
  end

end