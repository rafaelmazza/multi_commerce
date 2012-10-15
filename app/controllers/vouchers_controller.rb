class VouchersController < ApplicationController
  respond_to :html, :json
  
  layout 'voucher', only: [:show]
  
  def show
    @voucher = Voucher.find(params[:id])
  end
  
  def checkout
    @voucher = Voucher.find(params[:id])
    @lead = @voucher.lead
    @lead.attributes = params[:lead]
    
    params[:products].each do |product_id|
      @voucher.add_product(Product.find(product_id))
    end if params[:products]

    # if @voucher.lead.save && @voucher.update_attributes(params[:voucher])
    #   Akatus::Payment.perform(@voucher.id, @lead.credit_card)
    #   # PaymentWorker.perform_async(@voucher.id, @voucher.lead.credit_card)      
    #   @voucher.update! # updates total      
    #   render action: :show, id: @voucher.id
    # else
    #   render 'home/subscribe', layout: 'home'
    # end
    
    @voucher.attributes = params[:voucher]
    render :text => @voucher.valid?.inspect
  end
  
  def update
    @voucher = Voucher.find(params[:id])
    @voucher.update_attributes(params[:voucher])
    respond_with(@voucher)
  end
end