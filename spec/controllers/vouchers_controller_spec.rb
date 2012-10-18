require 'spec_helper'

describe VouchersController do
  let(:voucher) { mock(:voucher).as_null_object }
  
  describe 'GET show' do
    before do
      Voucher.stub(:find).with('voucher_id').and_return voucher
    end
    
    it 'assigns voucher' do      
      get :show, id: 'voucher_id'
      assigns(:voucher).should == voucher
    end
    
    it 'renders voucher layout' do
      get :show, id: 'voucher_id'
      response.should render_template('layouts/voucher')
    end
  end
  
  describe 'POST update_payment_status' do
    before do
      Voucher.stub(:find).with('referencia').and_return(voucher)
    end
    
    it 'does not render view' do
      post :update_payment_status, token: 'valid_token', transacao_id: 'id', status: 'Aprovado', referencia: 'referencia'
      response.body.strip.should be_empty
    end
    
    it 'updates voucher payment status' do
      Akatus::Payment.stub conf: {'akatus' => {'token_nip' => 'valid_token'}}
      voucher.should_receive(:update_attribute).with(:status, 'Aprovado')
      post :update_payment_status, token: 'valid_token', transacao_id: 'id', status: 'Aprovado', referencia: 'referencia'
    end
    
    context 'when token is invalid' do
      it 'returns 403' do
        post :update_payment_status, token: 'invalid_token', transacao_id: 'id', status: 'Aprovado', referencia: 'referencia'        
        response.status.should == 403
      end
    end
  end
  
  # describe 'POST checkout' do
  #   let(:voucher) { create(:voucher) }
  # 
  #   it 'should' do
  #     post :checkout, id: voucher.id
  #   end
  # end
end