class OrderItem < ActiveRecord::Base
  belongs_to :book
  belongs_to :order
  # has_one :book
  validates :book_id, :order_id, presence: true
  validates :quantity, numericality: { greater_than: 0}
end
