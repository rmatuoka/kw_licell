class ApplicationController < ActionController::Base
  helper :all 
  protect_from_forgery
#  filter_parameter_logging :password 
  helper_method :current_user
  
  private
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
  rescue_from 'Acl9::AccessDenied', :with => :access_denied
  
  def access_denied
    if current_user
      render :template => 'static_content/denied'
    else
      flash[:notice] = 'Acesso negado. Você precisa estar logado!'
      redirect_to login_path
    end
  end
  
  def load_site_categories
    @category_site = Category.menu
    #@banners_laterais = BannerCategory.lateral.banners
    dataandhora = DateTime.now 
    #@banners_home = BannerCategory.home.banners.all(:conditions => ['pub_end > ? and pub_start < ?',dataandhora,dataandhora])
  end
  
  def load_cart
    @cart = Cart.all(:select => '`carts`.*, `products`.`price`, `products`.`discount`, `products`.`name`',
                     :joins => 'INNER JOIN `products` ON `carts`.`product_id` = `products`.`id`',
                     :conditions => ['`products`.`price` > 0 AND IF(`products`.`stock_control` = 1, `products`.`stock_quantity` > 0 AND `products`.`published` = 1,  `products`.`published` = 1) and user_id = ?', current_user],
                     :include => [:product])
    @cart_total = @cart.sum {|item| ((item.price - item.discount) * item.amount)}
     
    #carrega_tagcloud
    @tagcloud = Keyword.tag_counts_on(:tags, :limit => 50, :order => 'count desc')
  end
  
  def logado
    if !current_user
      redirect_to root_path
    end
  end
end
