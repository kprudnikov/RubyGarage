class Rating < ActiveRecord::Base
  belongs_to :customer
  belongs_to :book
end
