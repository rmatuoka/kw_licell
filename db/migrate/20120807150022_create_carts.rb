class CreateCarts < ActiveRecord::Migration
  def self.up
    create_table :carts do |t|
      t.integer :user_id
      t.integer :product_id
      t.integer :amount,       :null => false, :default => 1
      t.timestamps
    end
  end

  def self.down
    drop_table :carts
  end
end
