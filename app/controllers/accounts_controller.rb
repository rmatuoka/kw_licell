class AccountsController < ApplicationController
  access_control do
    allow logged_in, :all
  end 
  layout "interna"
  before_filter :load_site_categories, :load_cart, :logado
  
  def index
    
  end
  
  
end
