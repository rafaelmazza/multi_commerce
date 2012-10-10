class VouchersController < ApplicationController
  layout 'voucher', only: [:show]
  
  def show
    @voucher = Voucher.find(params[:id])
  end
  
  def update
    @voucher = Voucher.find(params[:id])
    
    params[:products].each do |product_id|
      @voucher.add_product(Product.find(product_id))
    end if params[:products]
    
    @voucher.lead.update_attributes(params[:lead])
    
    @voucher.update_attributes(params[:voucher])
    @voucher.update! # updates total
    
    PaymentWorker.perform_async(@voucher.id, @voucher.lead.credit_card)
    # render 'home/thank_you'
    # redirect_to action: :thank_you, controller: :home, id: @voucher
    redirect_to voucher_path(@voucher)
    # render :text => PaymentWorker.perform_async(@voucher.id, @voucher.lead.credit_card)
    # render :text => Akatus::Payment.perform(@voucher)
  end
end