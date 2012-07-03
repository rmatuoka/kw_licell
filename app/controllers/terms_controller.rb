class TermsController < ApplicationController
  #access_control do
  #  allow logged_in, :all
  #end 
  before_filter :load_site_categories, :load_cart
  layout "interna"
  
  def index
  end
end
