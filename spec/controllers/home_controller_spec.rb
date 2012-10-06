require 'spec_helper'

describe HomeController do
  let(:geocoding) { File.read(Rails.root.join('spec', 'support', 'fixtures', 'geocoding.json')) }
  let(:address) { 'Rua Euclides Pacheco, 800' }
  let(:unities) { 5.times.map { create :unity, latitude: -46.5648306, longitude: -23.5474725 } }
  
  before do
    stub_request(:get, 'http://maps.googleapis.com/maps/api/geocode/json?address=Rua%20Euclides%20Pacheco,%20800&language=en&sensor=false')
      .with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'})
      .to_return(status: 200, body: geocoding, headers: {})

    mock_search = mock 'search_result', coordinates: [-23.5474725, -46.5648306], latitude: -23.5474725, longitude: -46.5648306
    Geocoder.stub(:search).and_return [mock_search]
  end
  
  describe 'GET unities' do
    let(:lead) { mock.as_null_object }
    let(:unities) { 3.times.map {mock.as_null_object} }
    
    before do
      Lead.stub find: lead
      unities.stub page: unities
      Unity.stub(:near).with(lead).and_return(unities)
    end
    
    it 'assigns lead' do
      get :unities, id: lead
      assigns(:lead).should == lead
    end
    
    it 'assigns unities' do
      get :unities, id: lead
      assigns(:unities).should have(3).unities
    end
  end
  
  describe 'GET subscribe' do
    let(:unity) { create(:unity) }
    let(:lead) { create(:lead) }
    let(:franchise) { create(:franchise, name: 'wizard', url: 'desconto.wizard.dev.br') }
    let(:products) { [create(:product, franchise: franchise)] }
    let(:voucher) { mock 'voucher' }
    
    before do
      controller.stub session: { lead_id: lead.id }
      # controller.request.stub server_name: 'desconto.wizard.dev.br'
      controller.stub current_franchise: franchise
      franchise.stub products: products
      lead.stub subscribe: voucher      
      Lead.stub find: lead
    end
    
    it 'assigns choosen unity' do
      get :subscribe, unity_id: unity
      assigns(:unity).should == unity
    end
    
    it 'assigns current lead' do
      get :subscribe, unity_id: unity
      assigns(:lead).should == lead
    end
    
    it 'assigns generated voucher' do
      get :subscribe, unity_id: unity
      assigns(:voucher).should == voucher
    end
    
    it 'assign products' do
      get :subscribe, unity_id: unity
      assigns(:products).should == products
    end
  end
  
  describe 'GET voucher' do
    let(:voucher) { mock 'voucher' }
    before do
      Voucher.stub(:find).with('voucher_id').and_return voucher
    end
    
    it 'assigns voucher' do      
      get :voucher, id: 'voucher_id'
      assigns(:voucher).should == voucher
    end
    
    it 'renders voucher layout' do
      get :voucher, id: 'voucher_id'
      response.should render_template('layouts/voucher')
    end
  end
  
  # describe 'POST search' do
  #   it 'assigns unities' do
  #     post :search, address: address
  #     assigns(:unities).should have(3).items
  #   end
  #   
  #   context 'when page is passed' do
  #     it 'should return the respective page' do
  #       get :search, address: address, page: 2
  #       assigns(:unities).should have(2).items
  #     end
  #   end
  # end
end