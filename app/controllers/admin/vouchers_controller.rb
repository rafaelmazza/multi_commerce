class Admin::VouchersController < Admin::ApplicationController
  load_and_authorize_resource
  respond_to :html, :csv
  
  def index
    @search = @admin_scope.vouchers.search(params[:q])    
    @vouchers = @search.result.page(params[:page])
    respond_with @vouchers
  end
  
  def use
    @voucher = current_user.vouchers.find(params[:id])
    @voucher.use
    flash[:alert] = 'Lead validado.' # TODO: change to notice
    redirect_to admin_lead_path(@voucher.lead)
  end
end