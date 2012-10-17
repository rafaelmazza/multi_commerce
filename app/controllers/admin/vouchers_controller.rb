class Admin::VouchersController < Admin::ApplicationController
  load_and_authorize_resource
  
  def index
    @vouchers = current_user.vouchers
  end
end