class CreditCard < ActiveRecord::Base
  validates_length_of :cvv, :exp_month, :exp_year, :firstname, :lastname, allow_blank: false
  validates_length_of :number, allow_blank: false
end