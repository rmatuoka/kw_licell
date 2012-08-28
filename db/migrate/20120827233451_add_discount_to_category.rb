class AddDiscountToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories, :discount, :decimal, :precision => 10, :scale => 2, :default => 0
  end

  def self.down
    remove_column :categories, :discount
  end
end
