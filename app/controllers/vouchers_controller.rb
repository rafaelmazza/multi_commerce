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
    
    @voucher.update_attributes(params[:voucher])    
    
    @voucher.lead.update_attributes(params[:lead])
    
    @voucher.update! # updates total
    
    render :text => Akatus::Payment.perform(@voucher.id)
  end
end