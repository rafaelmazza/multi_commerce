class Admin::ApplicationController < ApplicationController
  layout 'admin'

  before_filter :authenticate_user!
  # load_and_authorize_resource
  
  user_has_more_than_one_unity = Proc.new { current_user.role == 'unity' and current_user.unities.count > 1 }
  before_filter :show_available_unities, if: user_has_more_than_one_unity, except: [:available_unities, :select_unity]
  before_filter :set_admin_scope
  
  protected
  
  def set_admin_scope
    @admin_scope = current_user.manager? ? current_franchise : unity_scope
  end
  
  def unity_scope
    return current_user if not session[:unity_id]
    @current_unity ||= Unity.find(session[:unity_id])
  end
  
  def show_available_unities
    redirect_to controller: :dashboard, action: :available_unities unless session[:unity_id]
  end
end