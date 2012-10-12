class AddressesController < ApplicationController
  respond_to :json
  
  def show
    @address = Correios::CEP::search(params[:zipcode])
    respond_with(@address)
  end
end