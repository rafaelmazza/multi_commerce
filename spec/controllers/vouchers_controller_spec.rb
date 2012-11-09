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
  
  describe 'GET installments', wip: true do
    let(:akatus_response) { '{"resposta":{"descricao":"1,99% ao m\u00eas","parcelas_assumidas":0,"parcelas":[{"quantidade":1,"valor":"100.0","total":"100.0"},{"quantidade":2,"valor":"51.5","total":"102.99"},{"quantidade":3,"valor":"34.67","total":"104.0"},{"quantidade":4,"valor":"26.26","total":"105.02"},{"quantidade":5,"valor":"21.21","total":"106.04"},{"quantidade":6,"valor":"17.85","total":"107.07"},{"quantidade":7,"valor":"15.45","total":"108.11"},{"quantidade":8,"valor":"13.65","total":"109.16"},{"quantidade":9,"valor":"12.25","total":"110.21"},{"quantidade":10,"valor":"11.13","total":"111.26"},{"quantidade":11,"valor":"10.22","total":"112.33"},{"quantidade":12,"valor":"9.45","total":"113.4"}]}}' }

    before do
      stub_request(:get, 'https://www.akatus.com/api/v1/parcelamento/simulacao.json?email=akatus@cafeazul.com.br&amount=100&payment_method=cartao_visa&api_key=6494F2BA-CDEA-487A-9633-3B2CBFCA47F6')
        .with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'})
        .to_return(status: 200, body: akatus_response, headers: {})
    end
    
    it 'returns voucher installments' do
      get :installments, id: voucher, amount: 100, payment_method: 'cartao_visa', format: :json
      response.body.should == akatus_response
    end
  end
end