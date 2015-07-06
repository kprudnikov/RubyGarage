class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :firstname
      t.string :lastname
      t.text :biography
      t.references :books, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
