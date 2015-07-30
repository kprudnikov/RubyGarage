class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :category
  has_many :ratings
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  validates :title, :price, :in_stock, presence: true

  def self.most_popular
    # refactor? change behavior to
    Rating.all.sort_by{|rating| rating.rating}.last.book
  end

  def in_stock?
    self.in_stock > 0
  end
end
