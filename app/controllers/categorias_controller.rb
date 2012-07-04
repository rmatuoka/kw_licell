class CategoriasController < ApplicationController
  access_control do
    allow logged_in, :all
  end 
  layout "interna"
  before_filter :load_site_categories, :before, :load_cart
  
  def show
    @subcategorias = @categoria.subcategories.all
  end
  
  def before
    @categoria = Category.find(params[:id])
  end
end
