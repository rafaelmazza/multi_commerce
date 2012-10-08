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
    
    render :text => Akatus::Payment.perform(@voucher)
    # render :text => @voucher.lead.credit_card[:number].inspect
  end
end