require 'spec_helper'

describe Lead do
  it { should have_db_column(:name).of_type(:string) }
  it { should have_db_column(:email).of_type(:string) }
  it { should have_db_column(:phone_code).of_type(:string) }
  it { should have_db_column(:phone).of_type(:string) }
  it { should have_db_column(:address_search).of_type(:string) }
  it { should have_db_column(:latitude).of_type(:float) }
  it { should have_db_column(:longitude).of_type(:float) }
  
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:email) }  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:phone_code) }  
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:address_search) }  
  it { should validate_numericality_of(:phone_code) }
  it { should validate_numericality_of(:phone) }
  
  it { should belong_to(:unity) }
  
  describe '#subscribe' do
    let(:lead) { create(:lead) }
    let(:unity) { create(:unity) }
    
    it 'associates unity to lead' do
      lead.subscribe(unity)
      lead.unity.should == unity
    end
    
    it 'increments unity leads counter' do
      lead.subscribe(unity)
      unity.reload.leads_count.should == 1
    end
    # # pre-generate the voucher to have it associated
    # # even if the lead doesn't subscribe or print the voucher
    # generate_voucher
  end
end