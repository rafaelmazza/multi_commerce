class Admin::LeadsController < Admin::ApplicationController
  def index
    # @leads = Lead.all
    if current_user.role == 'manager'
      # @leads = current_user.franchises.first.unities.map { |u| u.leads }
      @leads = current_user.manager_leads
    else
      # @leads = current_user.unities.first.leads
      @leads = current_user.leads
    end
    # @leads = current_user.franchises.first.unities.map {|u| u.leads}
    # p current_user.franchises.first.unities.map {|u| u.leads}
    # render :text => 'ok'
  end
end