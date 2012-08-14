class AddPublishedToTag < ActiveRecord::Migration
  def self.up
    add_column :tags, :published, :boolean, :null => false, :default => 1
  end

  def self.down
    remove_column :tags, :published
  end
end
