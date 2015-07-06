class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.float :total_price
      t.datetime :completed_date
      t.string :state
      t.references :customer, index: true, foreign_key: true
      t.references :credit_card, index: true, foreign_key: true
      t.integer :billing_address
      t.integer :shipping_address

      t.timestamps null: false
    end
  end
end
