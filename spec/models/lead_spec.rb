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
  it { should have_many(:vouchers) }
  it { should have_one(:address) }
  
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
    
    it 'generates voucher' do
      expect { lead.subscribe(unity) }.to change(Voucher, :count).by(1)
    end
    
    it 'returns generated voucher' do
      voucher = mock('voucher')
      lead.should_receive(:generate_voucher).and_return(voucher)
      lead.subscribe(unity).should == voucher
    end
    
    it 'does not duplicate voucher for same unity' do
      voucher = create(:voucher, lead: lead, unity: unity)
      expect { lead.subscribe(unity) }.to_not change(Voucher, :count)
    end
  end
end