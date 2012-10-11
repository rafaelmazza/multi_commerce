class Admin::LeadsController < Admin::ApplicationController
  def index
    @leads = current_user.leads
  end
end