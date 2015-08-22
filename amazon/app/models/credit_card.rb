class CreditCard < ActiveRecord::Base
  validates :cvv, format: /\d{3}/
  validates_length_of :cvv, is: 3
  validates_length_of :number, is: 16
  validates_inclusion_of :exp_month, in: 1..12
  validates_numericality_of :exp_year, greater_than_or_equal_to: Time.now.year
  validates :firstname, :lastname, presence: true
end