class Admin::FeaturedsController < ApplicationController
  access_control do
    allow :admin, :supervisor
  end

  layout "admin"  
  
  def index
    @featureds = Featured.all
  end

  def show
    @featured = Featured.find(params[:id])
  end

  def new
    @featured = Featured.new(:published=>true)
  end

  def create
    @featured = Featured.new(params[:featured])
    if @featured.save
      redirect_to [:admin, @featured], :notice => "Successfully created featured."
    else
      render :action => 'new'
    end
  end

  def edit
    @featured = Featured.find(params[:id])
  end

  def update
    @featured = Featured.find(params[:id])
    if @featured.update_attributes(params[:featured])
      redirect_to [:admin, @featured], :notice  => "Successfully updated featured."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @featured = Featured.find(params[:id])
    @featured.destroy
    redirect_to admin_featureds_url, :notice => "Successfully destroyed featured."
  end
end
