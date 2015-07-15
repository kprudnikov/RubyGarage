class Customer < ActiveRecord::Base
  has_many :orders
  has_many :ratings
  has_many :credit_cards
  has_many :books, through: :orders
  validates :email, :password, :firstname, :lastname, presence: true
  validates :email, uniqueness: true
  validates :password, length: {minimum: 6}

  def in_progress
    self.orders.find{|order| order.state == "in progress"}
  end

  def all_in_progress
    self.orders.select{|order| order.state == "in progress"}
  end
end
