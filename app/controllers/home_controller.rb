class HomeController < ApplicationController
  layout 'home'
  
  before_filter :set_campaign_theme, only: [:index]
  
  def index
    @lead = Lead.new(campaign_id: @campaign.try(:id))
  end
  
  def unities
    p 'aqui session unities'
    p session.inspect
    @lead = Lead.find(session[:lead_id])
    @unities = current_franchise.unities.nearby(@lead).page params[:page]
  end
  
  def subscribe
    @lead = Lead.find(session[:lead_id])    
    @unity = Unity.find(params[:unity_id])
    @voucher = @lead.subscribe(@unity)
    skip_payment(@voucher) unless current_franchise.payment_enabled?
  end
  
  def privacy_policy    
  end
  
  private
  
  def skip_payment(voucher)
    # redirect_to controller: :vouchers, action: :show, id: voucher
    redirect_to controller: :vouchers, action: :success, id: voucher
  end
  
  def set_campaign_theme
    @campaign = Campaign.find_by_name(params[:source])
    theme @campaign.name if @campaign
  end
end