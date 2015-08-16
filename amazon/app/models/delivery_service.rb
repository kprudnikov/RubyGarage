class DeliveryService < ActiveRecord::Base
  has_many :orders
  validates :title, presence: true, allow_blank: false
  validates_numericality_of :cost, :on => :create
end