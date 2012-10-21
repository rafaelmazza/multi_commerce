class Admin::LeadsController < Admin::ApplicationController
  respond_to :html, :csv
  load_and_authorize_resource
  
  # has_scope :pending
  # has_scope :prospected
  # has_scope :enrolled
  # has_scope :by_period, :using => [:scope, :started_at, :ended_at]
  
  def index
    @search = current_user.leads.search(params[:q])
    @leads = @search.result.page(params[:page])
    respond_with @leads
    # @leads = apply_scopes(current_user.leads).page(params[:page])
    # respond_with(@leads)
    # render text: current_user.unities.length
  end
  
  def prospect
    Lead.update_all(["prospected_at = ?", Time.now], id: params[:bulk_ids])
    flash[:alert] = 'Lead(s) prospectado(s) com sucesso'
    redirect_to action: :index
  end
  
  def enroll
    Lead.update_all(["enrolled_at = ?", Time.now], id: params[:bulk_ids])
    flash[:alert] = 'Lead(s) matriculado(s) com sucesso'
    redirect_to action: :index
  end
end