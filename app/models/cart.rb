class Cart < ActiveRecord::Base
  belongs_to :user  
  belongs_to :product  
  
  def self.add_product(product,current_user)
    @cart = Cart.all(:conditions => ['user_id = ?', current_user])
    if !@cart.blank?
      current_item = @cart.find {|cart| cart.product_id == product.id}
      if current_item
        current_item.amount += 1
        current_item.save
      else
        item = Cart.new(:user_id =>current_user.id, :product_id=> product.id, :amount=> 1)
        item.save
      end
    else
      item = Cart.new(:user_id =>current_user.id, :product_id=> product.id, :amount=> 1)
      item.save
    end
  end


  def self.remove_product(product,current_user)
    @cart = Cart.all(:conditions => ['user_id = ?', current_user])
    if !@cart.blank?
      current_item = @cart.find {|cart| cart.product_id == product.id}
      if current_item
        current_item.amount -= 1
        current_item.save
      end
    end
  end 
  
  def self.remove_product_all(product,current_user)
    @cart = Cart.all(:conditions => ['user_id = ?', current_user])
    if !@cart.blank?
      current_item = @cart.find {|cart| cart.product_id == product.id}
      if current_item
        current_item.destroy
      end
    end
  end  
  
  def url_slug()
    "#{product_id}-#{name.parameterize}"
  end
  
end


=begin

current_item = @cart.select {|produto| cart.product_id == product}
 
if current_item
    current_item.increment_quantity
else
  item = Cart.new
  item.product_id = product.id
  item.save
  #@items << CartItem.new(product)
end


class Cart
  attr_reader :items
  
  def initialize
    @items =[]
  end
  
  def add_product(product)
    current_item = @items.find {|item| item.product == product}
  
    if current_item
        current_item.increment_quantity
    else
      @items << CartItem.new(product)
    end    
  end
  
  def remove_product(product)
    current_item = @items.find {|item| item.product == product}
  
    if current_item
        current_item.decrement_quantity
    else
        @items << CartItem.new(product)
    end
  end
  
  def remove_product_all(product)
    current_item = @items.find {|item| item.product == product}
    current_item.quantity.times do
      if current_item
          current_item.decrement_quantity
      else
          @items << CartItem.new(product)
      end
    end
  end
    
      
  def total_price
    @items.sum {|item| (item.price)}
  end
end
=end