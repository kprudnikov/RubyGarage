class ChangeDefaultOrderState < ActiveRecord::Migration
  def change
    change_column :orders, :state, :string, null: false, default: "in_progress"
  end
end
