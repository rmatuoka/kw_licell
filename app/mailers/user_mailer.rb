class UserMailer < ActionMailer::Base
  default :from => "Licell - Vendas <no-reply@licell.com.br>"
  
  #Enviado quando ocorrer o primeiro retorno do pagseguro!
  def transaction_initiated(order)
    @order = order
    mail(:to => order.user.email, :subject => "Transação Iniciada",:reply_to => "daniel@licell.com.br")
  end
  
  #Enviado quando o pagamento for concuido!
  def payment_made(order)
    @order = order
    @order_itens = OrderProduct.all(:conditions => ['order_id = ?', @order.id])
    mail(:to => order.user.email, :subject => "Pedido Efetuado",:reply_to => "daniel@licell.com.br")
  end
  
  #Enviado quando o código de rastreamento for inserido na tabela order!
  def inserting_tracking_code(order)
    
    
  end
  
 #Envia email (instruções para recuperar a senha)
	def send_email_password_reset(user)
    @user = user
		mail(:to => user.email, :subject => "Instruções para trocar a senha")
	end	
	
  
  #Enviado quando o pedido entrar no sistema!
  def order_start(order)
    @order = order
    @order_itens = OrderProduct.all(:conditions => ['order_id = ?', @order.id])    
    mail(:to=>"daniel@licell.com.br", :bcc => "sussumu@hdcomputers.com.br, log@korewa.com.br", :subject => @order.user.nome + " - Novo Pedido através do Site")
  end
  
  #Enviado quando o pagamento for concluido!
  def order_completed(order)
    @order = order
    @order_itens = OrderProduct.all(:conditions => ['order_id = ?', @order.id])    
    mail(:to=>"daniel@licell.com.br", :bcc => "sussumu@hdcomputers.com.br, log@korewa.com.br", :subject => @order.user.nome + " - Pagamento Efetuado")    
  end
  
  #Enviado quando o tem algum comentário em algum produto
  def user_commented(user, product)
    @user = user
    @product = product
    
    mail(:to=>"daniel@licell.com.br", :bcc => "sussumu@hdcomputers.com.br, log@korewa.com.br", :subject => @user.nome + " comentou no produto " + @product.name)    
  end
  
  def reports(vendasok)
     @vendasefetuadas = vendasok
     mail(:to => "daniel@licell.com.br", :bcc => "sussumu@hdcomputers.com.br, log@korewa.com.br", :subject => "Relatorio de Vendas aprovadas!")
   end
  
end
