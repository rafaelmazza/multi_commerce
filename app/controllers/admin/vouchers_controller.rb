class Admin::VouchersController < Admin::ApplicationController
  # load_and_authorize_resource
  respond_to :html, :csv
  
  # has_scope :paid
  # has_scope :pending
  
  def index
    # @vouchers = current_user.vouchers.page(params[:page])
    # respond_with @vouchers
    # params[:q] = 'status_eq=Aprovado'
    # @q = current_user.vouchers.search(params[:q])
    # @q = apply_scopes(current_user.vouchers).search(params[:q])
    @search = current_user.vouchers.search(params[:q])
    @vouchers = @search.result.page(params[:page])
    respond_with @vouchers
  end
  
  def use
    @voucher = current_user.vouchers.find(params[:id])
    @voucher.use
    flash[:alert] = 'Lead validado.' # TODO: change to notice
    redirect_to action: :index
    # render text: @voucher.inspect
  end
  
  # def search
  #   @q = current_user.vouchers.search(params[:q])
  #   @vouchers = @q.result(:distinct => true).page(params[:page])
  #   render :index
  # end
end