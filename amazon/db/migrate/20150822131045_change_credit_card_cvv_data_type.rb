class ChangeCreditCardCvvDataType < ActiveRecord::Migration
  def self.up
    change_column :credit_cards, :cvv, :string, default: "", null: false
  end

  def self.down
    change_column :credit_cards, :cvv, :integer
  end
end
