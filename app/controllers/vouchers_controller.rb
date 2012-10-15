class VouchersController < ApplicationController
  respond_to :html, :json
  
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
      Akatus::Payment.perform(@voucher)
      # PaymentWorker.perform_async(@voucher.id, @voucher.lead.credit_card)
      @voucher.update! # updates total      
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
end