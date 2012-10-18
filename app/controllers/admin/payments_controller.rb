class Admin::PaymentsController < Admin::ApplicationController
  def index
    @voucher = Voucher.find(params[:voucher_id])
    @payments = @voucher.payments
  end
end