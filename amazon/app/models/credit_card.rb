class CreditCard < ActiveRecord::Base
  belongs_to :customer
  validates :cvv, :exp_month, :exp_year, :firstname, :lastname, presence: true
end
