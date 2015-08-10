class AddNamesToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :firstname, :string, null: false, default: ""
    add_column :addresses, :lastname, :string, null: false, default: ""
  end
end
