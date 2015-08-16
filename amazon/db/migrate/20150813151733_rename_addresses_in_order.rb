class RenameAddressesInOrder < ActiveRecord::Migration
  def change
    rename_column :orders, :billing_address, :billing_address_id
    rename_column :orders, :shipping_address, :shipping_address_id
  end
end
