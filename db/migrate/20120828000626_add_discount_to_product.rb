class AddDiscountToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :discount_pj, :decimal, :precision => 10, :scale => 2, :default => 0
  end

  def self.down
    remove_column :products, :discount_pj
  end
end
