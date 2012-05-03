class Category < ActiveRecord::Base
  has_many :subcategories, :dependent => :destroy
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_length_of :name, :maximum => 10

  def self.menu  
    Category.all
  end 
  
  def url_slug()
    "#{id}-#{name.parameterize}"
  end  
end
