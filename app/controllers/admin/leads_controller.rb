class Admin::LeadsController < Admin::ApplicationController
  def index
    @leads = current_user.leads
  end
  
  def prospect
    Lead.update_all(["prospected_at = ?", Time.now], id: params[:bulk_ids])
    flash[:alert] = 'Leads prospectados com sucesso'
    redirect_to action: :index
  end
end