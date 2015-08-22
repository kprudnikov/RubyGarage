class OrderItem < ActiveRecord::Base
  belongs_to :book
  belongs_to :order
  validates :book_id, :order_id, presence: true
  validates :quantity, numericality: { greater_than: 0}

  before_create :set_item_price
  before_update :set_item_price
  after_create :calculate_order_price
  after_update :calculate_order_price

  def set_item_price
  	self.price = book.price
  end

  def calculate_order_price
  	self.order.calculate_total_price
  end

end
