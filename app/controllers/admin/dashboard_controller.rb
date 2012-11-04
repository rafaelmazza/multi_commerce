class Admin::DashboardController < Admin::ApplicationController
  skip_load_resource only: [:index]
  
  def index
  end
  
  def select_unity
    session[:unity_id] = params[:unity_id]
    redirect_to admin_root_path
  end
end