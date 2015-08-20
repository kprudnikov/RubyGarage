class AddDefaultValueToOrderDeliveryService < ActiveRecord::Migration
  def change
    change_column :orders, :delivery_service_id, :integer, null: false, default: 1
  end
end
