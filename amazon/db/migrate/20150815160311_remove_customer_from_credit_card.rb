class RemoveCustomerFromCreditCard < ActiveRecord::Migration
  def change
    remove_column :credit_cards, :customer_id
  end
end
