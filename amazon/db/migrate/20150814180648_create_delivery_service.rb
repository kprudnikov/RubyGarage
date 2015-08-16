class CreateDeliveryService < ActiveRecord::Migration
  def change
    create_table :delivery_services do |t|
      t.string :title, null: false, default: ""
      t.decimal :cost, null: false, default: 0.0
    end

    add_column :orders, :delivery_service_id, :integer
  end
end
