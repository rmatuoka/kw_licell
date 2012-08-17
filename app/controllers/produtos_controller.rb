class ProdutosController < ApplicationController
#  access_control do
#    allow logged_in, :all
#  end 
  before_filter :load_site_categories,  :load_cart
  before_filter :before, :except => :spreadsheet
  
  layout "interna", :except => [:spreadsheet]
  layout "blank", :only => [:spreadsheet]
  
  def show
    @produto = Product.find(params[:id])
    views = @produto.views + 1
    #@recomendados = @produto.recommendeds.all(:conditions => ['`products`.`price` > 0 AND IF(`products`.`stock_control` = 1, `products`.`stock_quantity` > 0 AND `products`.`published` = 1,  `products`.`published` = 1)'])
    @subcategoria = @produto.subcategory
    @recomendados = @subcategoria.products.all
    @produto.views = views
    @produto.save
    @categoria = Category.find(@produto.subcategory.category_id)
  end
  
  def add_to_cart
    product = Product.find(params[:id])
    if !product.blank?
      Cart.add_product(product,current_user)
    end
    redirect_to carrinhos_path
  end
  
  def remove_from_cart
    product = Product.find(params[:id])
    if !product.blank?    
      Cart.remove_product(product,current_user)
    end
    redirect_to carrinhos_path
  end
  
  def remove_all_from_cart
    product = Product.find(params[:id])
    if !product.blank?    
      Cart.remove_product_all(product,current_user)
    end
    redirect_to carrinhos_path
  end
  
  def add_to_wishlist
    @wishlist = current_user.wishlists.build
    @wishlist.user_id = current_user.id
    @wishlist.product_id = params[:id]
    @wishlist.save
    
    redirect_to wishlists_path
  end
  
  def remove_from_wishlist
    @wishlist = current_user.wishlists.first(:conditions => ['user_id = ?', current_user.id])
    @wishlist.destroy
    
    redirect_to wishlists_path
  end
  
  def before
    @produto = Product.find_by_id(params[:id])
    if @produto.blank?
      flash[:notice] = "Este produto não existe, tente novamente!"
      redirect_to root_path
    else    
      if !@produto.published
        redirect_to root_path
      else
        @subcategory = @produto.subcategory
        @category = @subcategory.category
        @subcategorias = @category.subcategories.all
      end
    end
  end
  
  def spreadsheet
    @productsall = Product.all_published  
    respond_to do |format|
        format.html
        format.pdf do
          
          d = DateTime.now.strftime("%d-%m-%Y")
          render  :pdf => "Tabela Preços Licell #{d}", 
                  :template => "/produtos/spreadsheet2.html.erb",
                  :show_as_html => params[:debug].present?,
                  :margin => {:top                => 15,                     # default 10 (mm)
                              :bottom             => 15,
                              :left               => 10,
                              :right              => 10},                  
                  :page_size => 'A4'#,
                 # :header => {:html => { :template => '/static_content/denied.html.erb',  # use :template OR :url      # optional, use 'pdf_plain.html' for a pdf_plain.html.erb file, defaults to main layout
                  #                       :url      => 'www.example.com',
                   #                      :locals   => { :foo => @bar }
                    #                   },
                     #         }                  
                  
        end
    end     
  end
  
end
