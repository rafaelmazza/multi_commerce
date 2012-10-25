require 'spec_helper'

describe Admin::VouchersController do
  before do
    controller.stub current_franchise: create(:franchise)
  end
  
  context 'when logged as unity' do
    login_unity

    describe 'GET index' do
      it 'assigns vouchers' do
        get :index
        assigns[:vouchers].should_not be_nil
      end
    end
  end
  
  context 'when logged as unity' do
    login_manager

    describe 'GET index' do
      it 'assigns vouchers' do
        get :index
        assigns[:vouchers].should_not be_nil
      end
    end
  end
end