class UserSessionsController < ApplicationController
  layout "interna"
  before_filter :load_site_categories, :load_cart
  
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_to logado_user_sessions_path
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    redirect_to root_url, :notice => "Sessão finalizada com sucesso!"
  end
end
