class UsersController < ApplicationController
  layout "interna"
  before_filter :load_site_categories, :load_cart
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.role = "user"
    if @user.save_without_session_maintenance
      @user.deliver_activation_instructions!
      redirect_to user_path(@user)
      #redirect_to accounts_path, :notice => "Usuário Cadastrado com Sucesso!"
    else
      render :action => 'new'
    end
  end

  def show
    #@user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to accounts_path, :notice  => "Dados do usuário alterados!"
    else
      render :action => 'edit'
    end
  end
end
