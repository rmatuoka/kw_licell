class ActivationsController < ApplicationController
  #before_filter :require_no_user

  def edit
    @user = User.find_using_perishable_token(params[:id], 1.week) # || (raise Exception)
    #@user = User.find_using_perishable_token(params[:activation_code], 1.week) || (raise Exception)
    #raise Exception if @user.active?
    if @user
      if @user.activate!
        flash[:notice] = "Sua conta foi ativada! Você está logado(a)!"
        UserSession.create(@user, false) # Log user in manually
        @user.deliver_welcome!
        redirect_to root_path
      else
        render :action => :new
      end
    else
      flash[:notice] = "Ocorreu um erro! Tente novamente!"
      redirect_to root_path
    end
  end

end
