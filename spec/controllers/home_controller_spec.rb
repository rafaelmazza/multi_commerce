require 'spec_helper'

describe HomeController do
  describe 'GET unities' do
    # let(:let) { create(:lead) }
    let(:lead) { mock.as_null_object }
    let(:unities) { 3.times.map {mock.as_null_object} }
    before do
      Lead.stub find: lead
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
end