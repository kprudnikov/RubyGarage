class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :category
  has_many :ratings, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  validates :title, :price, :in_stock, presence: true
  mount_uploader :cover, CoverUploader

  def self.most_popular
    Rating.all.sort_by{|rating| rating.rating}.last.book
  end

  def in_stock?
    self.in_stock > 0
  end

  def has_cover?
    self.cover.to_s.length > 0
  end
end
