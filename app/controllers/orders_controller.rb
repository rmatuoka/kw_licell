class OrdersController < ApplicationController
  require 'digest/md5'
  access_control do
    allow logged_in, :all
  end 
  before_filter :load_site_categories, :load_cart
  layout "interna"
  
  def new
    
  end
  
  def create
      #Inicio do Order!
      @order = Order.new
      #GRAVAR TRANSACAO NO BANCO , OS ITENS COMPRADOS ESTAO GRAVADOS NO CARRINHO
      #VERIFICA SE EXISTE A TRANSACAO
      @order.user_id = current_user.id
      @order.status = "incompleted"
    
      if !@order.save
        #erro
        flash[:notice] = "Erro ao gravar transação"
      else
        @controle100 = false
        if (@cart.total_price >= 100.to_i)
          @controle100 = true
        end
        #GERAR PEDIDO
        @order.order_check = Digest::MD5.hexdigest(@order.id.to_s + @order.user_id.to_s + @order.created_at.to_s)
        @order.save
        @order_product = PagSeguro::Order.new(@order.id)
        #PEGA ITENS DO CARRINHO E ADICIONA AO PEDIDO E FINALIZA
      
        if !@cart.items.blank?
          for cart_item in @cart.items
            @pedidos = @order.order_products.build
            @pedidos.product_id = cart_item.id_product
            @pedidos.amount = cart_item.quantity
            @pedidos.price = cart_item.price
            @pedidos.save
          
            @order_product.billing = {
              :name                  => current_user.nome,
              :email                 => current_user.email
            }
	          if (@cart.total_price >= 100.to_i)	          
              @order_product.add :id => cart_item.id_product, :quantity => cart_item.quantity,  :price => (cart_item.price/cart_item.quantity), :description => cart_item.title #, :weight => 0.250, 
            else
              @order_product.add :id => cart_item.id_product, :quantity => cart_item.quantity,  :price => (cart_item.price/cart_item.quantity), :description => cart_item.title , :weight => cart_item.product.weight 
            end
          end
        end
      end
      #LIMPA CARRINHO
      session[:cart] = nil
      #Fim do Order
  end
  
  def edit
    @order = Order.find_by_order_check(params[:id], :conditions=>['user_id = ?', current_user.id])
    @order.status = "pending"
    @order.payment_type = "own_payment"
    if @order.save
      UserMailer.transaction_own(@order).deliver
      UserMailer.order_own(@order).deliver
    end
  end
end
