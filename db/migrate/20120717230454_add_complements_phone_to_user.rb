class AddComplementsPhoneToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :area_phone, :integer
    add_column :users, :area_cellphone, :integer
  end

  def self.down
    remove_column :users, :area_cellphone
    remove_column :users, :area_phone
  end
end
