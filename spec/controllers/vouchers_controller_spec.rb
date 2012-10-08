require 'spec_helper'

describe VouchersController do
  describe 'GET show' do
    let(:voucher) { mock 'voucher' }
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
end