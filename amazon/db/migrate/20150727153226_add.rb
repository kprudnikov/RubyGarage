class Add < ActiveRecord::Migration
  def change
    change_column :authors, :biography, :text, null: false, default: ""
  end
end
