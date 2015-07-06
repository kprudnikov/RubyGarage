class RemoveBooksFromCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :books_id
  end
end
