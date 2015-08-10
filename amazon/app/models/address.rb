class Address < ActiveRecord::Base
  belongs_to :country
  validates :address, :zipcode, :city, :phone,  presence: true
  # belongs_to :customer
  # belongs_to :orders
end
