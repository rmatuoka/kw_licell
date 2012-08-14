class AddFeaturedOrderToFeatured < ActiveRecord::Migration
  def self.up
    add_column :featureds, :featured_order, :integer, :null => false, :default => 1
  end

  def self.down
    remove_column :featureds, :featured_order
  end
end
