class HomeController < ApplicationController
  layout "home"
  
  def index
    @lead = Lead.new
  end
  
  def unities
    @lead = Lead.find(params[:id])
    @unities = Unity.near(@lead)
  end
end