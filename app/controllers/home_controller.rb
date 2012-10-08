class HomeController < ApplicationController
  layout 'home'
  
  def index
    @lead = Lead.new
  end
  
  def unities
    @lead = Lead.find(session[:lead_id])
    @unities = Unity.near(@lead).page params[:page]
  end
  
  def subscribe
    @lead = Lead.find(session[:lead_id])    
    @unity = Unity.find(params[:unity_id])
    @voucher = @lead.subscribe(@unity)
    
    @products = current_franchise.products # tmp
  end
end