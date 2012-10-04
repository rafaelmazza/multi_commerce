class HomeController < ApplicationController
  layout "home"
  
  def index
    @lead = Lead.new
  end
  
  def unities
    @lead = Lead.find(session[:lead_id])
    @unities = Unity.near(@lead)
  end
  
  def subscribe
    @lead = Lead.find(session[:lead_id])    
    @unity = Unity.find(params[:unity_id])
    @lead.subscribe(@unity)
  end
end