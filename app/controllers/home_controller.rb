class HomeController < ApplicationController
  layout 'home'
  layout 'voucher', only: 'voucher'
  
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
  end
  
  def voucher
    @voucher = Voucher.find(params[:id])
  end
end