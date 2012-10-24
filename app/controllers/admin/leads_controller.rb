class Admin::LeadsController < Admin::ApplicationController
  respond_to :html, :csv
  load_and_authorize_resource
    
  def index
    @search = @admin_scope.leads.search(params[:q])
    @leads = @search.result.page(params[:page])
    respond_with @leads
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