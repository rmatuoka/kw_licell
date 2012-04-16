class ProductImage < ActiveRecord::Base
  belongs_to :product
  
  has_attached_file :image, :styles => { :medium => "194x198>", :thumb => "100x128>" }
end
