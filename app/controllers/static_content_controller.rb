class StaticContentController < ApplicationController
  access_control do
    allow logged_in, :all
  end 

  def index
    
  end

  def denied
    
  end

end
