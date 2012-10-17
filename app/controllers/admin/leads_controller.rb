class Admin::LeadsController < Admin::ApplicationController
  load_and_authorize_resource
  
  has_scope :prospected
  has_scope :enrolled
  has_scope :by_period, :using => [:field, :started_at, :ended_at]
  
  def index
    @leads = apply_scopes(current_user.leads).all
  end
  
  def prospect
    Lead.update_all(["prospected_at = ?", Time.now], id: params[:bulk_ids])
    flash[:alert] = 'Leads prospectados com sucesso'
    redirect_to action: :index
  end
end