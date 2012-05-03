class SubcategoriasController < ApplicationController
  layout "interna"
  before_filter :load_site_categories, :before, :load_cart
  
  def show
    @products = @subcategory.products.all_published.paginate :page => params[:page]
  end 
  def before
    @subcategory = Subcategory.find(params[:id])
    @categoria = Category.find(@subcategory.category_id)
    @subcategorias = @categoria.subcategories.all
  end
end
