class AddAdminToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :admin, :boolean, null: false, default: false
  end
end
