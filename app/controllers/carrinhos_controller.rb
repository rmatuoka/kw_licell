class CarrinhosController < ApplicationController
  access_control do
    allow logged_in, :all
  end 
  before_filter :load_site_categories, :load_cart
  layout "interna"
  
  def index
    
       

    if !params[:gift_cod].blank?
      if !params[:gift_cod].empty?
        #VALE PRESENTE
        @gift = Gift.find_by_code(params[:gift_cod])
      
        if @gift
          #ACHOU
          @total_final = @cart_total - @gift.discount
        else
          #NAO ACHOU
          @total_final = @cart_total
        end
      end
    else
      @total_final = @cart_total
    end

    
  end
  
  def empty_cart
    
    if !@cart.blank?
      @cart.each do |item|
        item.destroy
      end
    end
    redirect_to carrinhos_path
  end
end
