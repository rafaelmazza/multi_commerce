class HomeController < ApplicationController
  layout "home"
  
  def index
    @lead = Lead.new
  end
  
  def unities
    
  end
end