class Customer < ActiveRecord::Base
  has_many :orders, :ratings, :credit_cards
  has_many :books, through: :orders
  validates :email, :password, :firstname, :lastname, presence: true
  validates :email, uniqueness: true
  validates :password, length: {minimum: 6}
end
