class AddDefaultValueToOrderDeliveryService < ActiveRecord::Migration
  def change
    change_column :orders, :delivery_service_id, null: false, default: 1
  end
end
