class HomeController < ApplicationController
#   access_control do
#    allow logged_in, :all
#  end  
  
  before_filter :load_site_categories, :load_cart
  layout "home"
  
  def index
    @mais_vistos = Product.six_most_viewed
    @destaques = Featured.all(:conditions => ['`featureds`.`featured_image_file_name` is not null 
        AND IF(`featureds`.`check_date` = 1, `featureds`.`pub_end` >= now() 
        AND `featureds`.`pub_start` <= now() 
        AND `featureds`.`published` = 1,  `featureds`.`published` = 1)
      	'],
      	:order=> '`featureds`.`featured_order` desc, `featureds`.`id`')
  end
end
