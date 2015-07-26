class AddDefaultQuantityToOrderItems < ActiveRecord::Migration
  def change
    change_column :order_items, :quantity, :integer, null: false, default: 1
  end
end