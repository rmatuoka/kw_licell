class Featured < ActiveRecord::Base
  #attr_accessible :name, :published, :check_date, :pub_start, :pub_end, :link, :link_target
  has_attached_file :featured_image, :styles => { :thumb => "200x65>", :featured_home => "916x296>" }

end
