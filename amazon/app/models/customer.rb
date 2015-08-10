class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders
  has_many :ratings
  has_many :credit_cards
  has_many :books, through: :orders
  belongs_to :billing_address, class_name: "Address"
  belongs_to :shipping_address, class_name: "Address"
  # validates :email, :firstname, :lastname, presence: true
  # validates :email, uniqueness: true
  # validates :password, length: {minimum: 8}

  def order_in_progress
    self.orders.find_by(state: "in_progress")
    # self.orders.find{|order| order.state == "in progress"}
  end

  def admin?
    self.admin
  end
end
