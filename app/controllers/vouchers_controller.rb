class VouchersController < ApplicationController
  respond_to :html, :json
  
  before_filter :validate_akatus_token, only: :update_payment_status
  
  layout 'voucher', only: [:show]
  
  def show
    @voucher = Voucher.find(params[:id])
  end
  
  def checkout
    @voucher = Voucher.find(params[:id])
    
    params[:products].each do |product_id|
      @voucher.add_product(Product.find(product_id))
    end if params[:products]

    if @voucher.update_attributes(params[:voucher])
      @voucher.update! # updates total
      Akatus::Payment.perform(@voucher)
      # PaymentWorker.perform_async(@voucher.id, @voucher.lead.credit_card)
      render action: :show, id: @voucher.id
    else
      render 'home/subscribe', layout: 'home'
    end
  end
  
  def update
    @voucher = Voucher.find(params[:id])
    @voucher.update_attributes(params[:voucher])
    respond_with(@voucher)
  end
  
  def update_payment_status
    return unless params[:referencia] and params[:status]
    voucher = Voucher.find(params[:referencia])
    voucher.update_attribute(:status, params[:status])
    render nothing: true
  end
  
  private
  
  def validate_akatus_token
    head :forbidden unless valid_token?
  end
  
  def valid_token?
    params[:token] == Akatus::Payment.conf['akatus']['token_nip']
  end
end