class Customer < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :books, through: :orders
  belongs_to :billing_address, class_name: "Address", dependent: :destroy
  belongs_to :shipping_address, class_name: "Address", dependent: :destroy

  def order_in_progress
    self.orders.find_by(state: "in_progress")
  end

  def admin?
    self.admin
  end
end
