class AddOrderCheckToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :order_check, :string
  end

  def self.down
    remove_column :orders, :order_check
  end
end
