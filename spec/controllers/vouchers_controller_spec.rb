require 'spec_helper'

describe VouchersController do
  let(:voucher) { create(:voucher) }
  
  describe 'GET show' do
    before do
      Voucher.stub(:find).with('voucher_id').and_return voucher
    end
    
    context 'for current lead' do
      before do
        session[:lead_id] = voucher.lead.id
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
    
    context 'for any other lead' do
      it 'raises exception when try to access' do
        expect { get :show, id: 'voucher_id' }.to raise_error CanCan::AccessDenied
      end
    end    
  end
  
  describe 'POST update_payment_status' do
    context 'when token is valid' do
      let(:params) { {token: 'valid_token', transacao_id: 'id', status: 'Aprovado', referencia: voucher.id} }
      
      before do
        Akatus::Payment.stub conf: {'akatus' => {'token_nip' => 'valid_token'}}
        Voucher.stub(:find).with(voucher.id.to_s).and_return(voucher)
        Sidekiq::Extensions::DelayedMailer.drain
      end
      
      it 'does not render view' do
        post :update_payment_status, params
        response.body.strip.should be_empty
      end

      it 'updates voucher payment status' do
        post :update_payment_status, params
        voucher.status.should == 'Aprovado'
      end
      
      it 'queue payment approved notification email' do
        post :update_payment_status, params
        Sidekiq::Extensions::DelayedMailer.jobs.size.should == 1
      end
    end
    
    context 'when token is invalid' do
      it 'returns 403' do
        post :update_payment_status, token: 'invalid_token', transacao_id: 'id', status: 'Aprovado', referencia: 'referencia'        
        response.status.should == 403
      end
    end
  end
end