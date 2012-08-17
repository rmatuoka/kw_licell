class Admin::UsersController < ApplicationController
  access_control do
    allow :admin, :supervisor
  end
  
  layout "admin"
  
  def index
    @users = User.all.paginate :page => params[:page],:per_page => 20
  end

  def show
    @user = User.find(params[:id])
  end
  
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to admin_user_path(@user), :notice  => "Dados Atualizados com sucesso!"
    else
      render :action => 'edit'
    end
  end
  
  def search
    if !params[:keyword].blank?
      @Results = User.search_for(params[:keyword]).paginate :page => params[:page],:per_page => 20
    end
  end
  
  def user_active
    @user = User.find_by_id(params[:id])
    if !@user.blank?
      @user.active = true
      @user.save
      redirect_to admin_user_path(@user), :notice  => "Dados Atualizados com sucesso!"
    else
      redirect_to admin_root_path
    end
    
  end
  
end
