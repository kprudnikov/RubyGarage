class RemoveBooksFromAuthor < ActiveRecord::Migration
  def change
    remove_column :authors, :books_id
  end
end
