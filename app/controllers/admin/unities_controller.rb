class Admin::UnitiesController < Admin::ApplicationController
  respond_to :html
  
  def index
    @search = @admin_scope.unities.select('unities.*, count(leads.id) as enrolled_leads_count').joins([:leads, :franchise]).group('unities.id').order('enrolled_leads_count DESC').where('leads.enrolled_at IS NOT NULL').search(params[:q])
    @unities = @search.result.page(params[:page])
    p @unities.inspect
    respond_with @unities
  end
end