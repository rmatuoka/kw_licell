class Admin::StaticContentsController < ApplicationController
  access_control do
    allow :admin, :supervisor
  end
  
  layout "admin"
    
  def index
    
  end

end
