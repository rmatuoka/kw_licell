class WishlistsController < ApplicationController
  access_control do
    allow logged_in, :all
  end 
  
  layout "interna"
  before_filter :load_site_categories, :load_cart, :logado
  
  def index
    @wishlists = current_user.wishlists.all.paginate :page => params[:page]
  end
  
  def logado
    if !current_user
      redirect_to root_path
    end
  end
end
