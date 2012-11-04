class Admin::DashboardController < Admin::ApplicationController
  skip_load_resource only: [:index]
  
  def index
  end
  
  def select_unity
    if current_user.unities.map(&:id).include?(params[:unity_id].to_i)
      session[:unity_id] = params[:unity_id]
      redirect_to admin_root_path
    else
      redirect_to admin_available_unities_path
    end
  end
end