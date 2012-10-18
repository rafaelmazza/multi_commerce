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
      payment = Akatus::Payment.perform(@voucher)
      if payment.success?
        render action: :show, id: @voucher.id
      else
        render text: payment.inspect
      end
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
  
  # TODO: tmp
  def installments
    # uri = URI('https://www.akatus.com/api/v1/parcelamento/simulacao.json?email=akatus@cafeazul.com.br&amount=100&payment_method=cartao_visa&api_key=6494F2BA-CDEA-487A-9633-3B2CBFCA47F6')
    uri = URI('https://www.akatus.com/api/v1/parcelamento/simulacao.json')
    p = { 
      :email => 'akatus@cafeazul.com.br',
      :amount => params['amount'].gsub('\D', ''),
      :payment_method => params['payment_method'],
      :api_key => '6494F2BA-CDEA-487A-9633-3B2CBFCA47F6'
    }
    uri.query = URI.encode_www_form(p)
    res = Net::HTTP.start(uri.host, use_ssl: true, verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
      http.get uri.request_uri, 'User-Agent' => 'MyLib v1.2'
    end
    respond_with(res.body)
  end
  
  private
  
  def validate_akatus_token
    head :forbidden unless valid_token?
  end
  
  def valid_token?
    params[:token] == Akatus::Payment.conf['akatus']['token_nip']
  end
end