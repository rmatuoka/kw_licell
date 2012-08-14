class CreateFeatureds < ActiveRecord::Migration
  def self.up
    create_table :featureds do |t|
      t.string :name
      t.boolean :published
      t.boolean :check_date
      t.datetime :pub_start
      t.datetime :pub_end
      t.string :link
      t.string :link_target
      t.string :featured_image_file_name
      t.string :featured_image_content_type
      t.integer :featured_image_file_size
      t.datetime :featured_image_updated_at      
      t.timestamps
    end
  end

  def self.down
    drop_table :featureds
  end
end
