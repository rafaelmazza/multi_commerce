class VouchersController < ApplicationController
  load_and_authorize_resource only: ['show', 'success']
  
  respond_to :html, :json
  
  protect_from_forgery except: :update_payment_status
  before_filter :validate_akatus_token, only: :update_payment_status
  
  layout 'home'
  
  rescue_from Akatus::ConnectionFailed, with: :connection_failed
  rescue_from Akatus::PaymentFailed, with: :connection_failed
  
  def connection_failed(error)
    flash[:alert] = error.message
    render 'home/subscribe'
  end
  
  def show
    @voucher = Voucher.find(params[:id])
    render layout: 'voucher'
  end
  
  def checkout
    @voucher = Voucher.find(params[:id])
    
    params[:products].each do |product_id|
      @voucher.add_product(Product.find(product_id))
    end if params[:products]
    
    @voucher.update_attributes(params[:voucher])
    
    if @voucher.valid?
      @voucher.update_total!
      Akatus::Payment.perform(@voucher)
      redirect_to success_voucher_path(@voucher)
    else
      render 'home/subscribe'
    end
  end
  
  def success
    @voucher = Voucher.find(params[:id])
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
    UserMailer.delay_for(1.minute).payment_approved(voucher) if voucher.payment_approved?
    render nothing: true
  end
  
  def installments
    respond_with Akatus::Payment.installments(params[:amount], params[:payment_method])
  end
  
  private
  
  def validate_akatus_token
    head :forbidden unless valid_token?
  end
  
  def valid_token?
    params[:token] == Akatus::Payment.conf['akatus']['token_nip']
  end
end