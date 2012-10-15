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

    if @voucher.lead.save && @voucher.update_attributes(params[:voucher])
      @voucher.update! # updates total
      # render action: :show, id: @voucher.id
      # render :text => Akatus::Payment.perform(@voucher)
    else
      render 'home/subscribe', layout: 'home'
    end
    
    # render text: Lead.new(params[:lead]).credit_card.number.inspect
    # render text: @lead.credit_card.valid?.inspect
    # if @lead.valid? #and @lead.credit_card.valid?
    # else
    #   render 'home/subscribe', layout: 'home'
    # end
    
    # PaymentWorker.perform_async(@voucher.id, @voucher.lead.credit_card)
    # render 'home/thank_you'
    # redirect_to action: :thank_you, controller: :home, id: @voucher
    # redirect_to voucher_path(@voucher)
    # render :text => PaymentWorker.perform_async(@voucher.id, @voucher.lead.credit_card)
    # render :text => Akatus::Payment.perform(@voucher)
  end
  
  def update
    @voucher = Voucher.find(params[:id])
    @voucher.update_attributes(params[:voucher])
    respond_with(@voucher)
  end
end