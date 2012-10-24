class Admin::ApplicationController < ApplicationController
  layout 'admin'

  before_filter :authenticate_user!
  # load_and_authorize_resource
  
  before_filter :set_admin_scope
  
  protected
  
  def set_admin_scope
    @admin_scope = current_user.manager? ? current_franchise : current_user
  end
end