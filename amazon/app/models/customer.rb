class Customer < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :books, through: :orders
  belongs_to :billing_address, class_name: "Address", dependent: :destroy
  belongs_to :shipping_address, class_name: "Address", dependent: :destroy

  after_create :create_empty_order

  def order_in_progress
    self.orders.find_by(state: "in_progress")
  end

  def admin?
    self.admin
  end

  def create_empty_order
    if !self.order_in_progress
      Order.create(customer_id: self.id)
    end
  end

end