class ChangeCustomerFields < ActiveRecord::Migration
  def change

    change_column :customers, :firstname, :string, null: false, default: ""
    change_column :customers, :lastname, :string, null: false, default: ""
    remove_column :customers, :password

  end
end
