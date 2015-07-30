class Rating < ActiveRecord::Base
  belongs_to :customer
  belongs_to :book
  validates_inclusion_of :rating, in: 1..10
  validates :book_id, :customer_id, presence: true
end
