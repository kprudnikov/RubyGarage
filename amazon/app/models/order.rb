class Order < ActiveRecord::Base
  belongs_to :billing_address, class_name: "Address", foreign_key: "billing_address"
  belongs_to :shipping_address, class_name: "Address", foreign_key: "shipping_address"
  has_many :order_items
  has_many :books, through: :order_items
  validates :total_price, :completed_date, :state, presence: true

  def add_book(book)
    self.order_items << OrderItem.new(book: book)
  end

end
