class Admin::VouchersController < Admin::ApplicationController
  load_and_authorize_resource
  respond_to :html, :csv
  
  def index
    @vouchers = current_user.vouchers.page(params[:page])
    respond_with @vouchers
  end
end