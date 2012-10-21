class Admin::VouchersController < Admin::ApplicationController
  # load_and_authorize_resource
  respond_to :html, :csv
  
  def index
    # @vouchers = current_user.vouchers.page(params[:page])
    # respond_with @vouchers
    @q = current_user.vouchers.search(params[:q])
    @vouchers = @q.result(:distinct => true).page(params[:page])
    respond_with @vouchers
  end
  
  # def search
  #   @q = current_user.vouchers.search(params[:q])
  #   @vouchers = @q.result(:distinct => true).page(params[:page])
  #   render :index
  # end
end