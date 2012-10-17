require 'spec_helper'

describe Admin::LeadsController do
  describe 'when logged as unity' do
    login_unity
    
    describe 'POST prospect' do
      let(:leads) { 3.times.map { create(:not_prospected_lead) } }
      let(:lead_ids) { leads.map(&:id) }
      let(:time_now) { Time.now }

      before do
        Time.stub now: time_now
      end

      it 'sets current time on prospected lead' do
        post :prospect, {bulk_ids: lead_ids}
        Lead.find(lead_ids).each do |lead|
          lead.prospected_at.should == time_now
        end
      end
    end
  end
end