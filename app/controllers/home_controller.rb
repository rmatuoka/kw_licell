class HomeController < ApplicationController
#   access_control do
#    allow logged_in, :all
#  end  
  
  before_filter :load_site_categories, :load_cart
  layout "home"
  
  def index
    @mais_vistos = Product.six_most_viewed
  end
end
