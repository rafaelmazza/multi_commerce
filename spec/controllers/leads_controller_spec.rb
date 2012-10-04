require 'spec_helper'

describe LeadsController do
  describe 'POST create' do
    context 'valid attributes' do
      it 'should save lead' do
        expect { post :create, :lead => attributes_for(:lead) }.to change(Lead, :count).by(1)
      end
      
      it 'redirects to unities page' do
        post :create, :lead => attributes_for(:lead)
        response.should redirect_to action: :unities, controller: :home
      end
      
      context 'when email already exists' do
        let!(:lead) { create(:lead, name: 'Rafael', email: 'rafael@cafeazul.com.br') }
        
        it 'replace lead info' do
          post :create, :lead => { name: 'John', email: 'rafael@cafeazul.com.br', phone_code: '11', phone: '501517001' }
          lead.reload.name.should == 'John'
        end
      end
    end
    
    context 'invalid attributes' do
      it 'renders home index template' do
        post :create, lead: attributes_for(:lead, email: 'invalid@email')
        response.should render_template 'home/index'
      end
    end
  end
end