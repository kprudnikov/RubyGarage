class Category < ActiveRecord::Base
  # belongs_to :books
  has_many :books
  validates :title, presence: true, uniqueness: true
end
