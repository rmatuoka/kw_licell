class OrdersController < ApplicationController
  access_control do
    allow logged_in, :all
  end 
  before_filter :load_site_categories, :load_cart
  layout "interna"
  
  def new
    
  end
  
  def create
	  if (@cart.total_price >= 100.to_i)	    
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
        #GERAR PEDIDO
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
          
            @order_product.add :id => cart_item.id_product, :quantity => cart_item.quantity,  :price => (cart_item.price/cart_item.quantity), :description => cart_item.title #, :weight => 0.250, 
          
          end
        end
      end
      #LIMPA CARRINHO
      session[:cart] = nil
      #Fim do Order
    else
      flash[:notice] = "Valor não pode ser inferior a R$ 100,00."
      redirect_to carrinhos_path
    end
  end
end
