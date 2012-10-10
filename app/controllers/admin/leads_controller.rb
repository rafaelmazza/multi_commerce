class Admin::LeadsController < Admin::ApplicationController
  def index
    # @leads = current_user.unities.first.leads
    @leads = current_user.franchises.first.unities.map {|u| u.leads}
    # p current_user.franchises.first.unities.map {|u| u.leads}
    # render :text => 'ok'
  end
end