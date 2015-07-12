class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :category
  has_many :ratings
  validates :title, :price, :in_stock, presence: true
end
