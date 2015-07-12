class AddedDefaultStateForOrders < ActiveRecord::Migration
  def up
    change_column :orders, :state, :string, default: "in progress"
  end

  def down
    change_column :orders, :state, :string, default: nil
  end
end
