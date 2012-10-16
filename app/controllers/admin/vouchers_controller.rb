class Admin::VouchersController < Admin::ApplicationController
  def index
    @vouchers = current_user.vouchers
  end
end