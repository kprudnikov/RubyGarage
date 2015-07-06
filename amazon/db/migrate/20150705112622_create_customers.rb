class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.text :email
      t.text :password
      t.text :firstname
      t.text :lastname

      t.timestamps null: false
    end
  end
end
