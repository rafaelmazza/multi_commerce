require 'spec_helper'

describe Unity do
  # it { should have_db_column(:code).of_type(:string) }
  # it { should have_db_column(:franchise_acronym).of_type(:string) }  
  # it { should have_db_column(:name).of_type(:string) }
  # it { should have_db_column(:status).of_type(:string) }
  # it { should have_db_column(:situation).of_type(:string) }
  # it { should have_db_column(:email).of_type(:string) }
  # it { should have_db_column(:phone).of_type(:string) }
  # it { should have_db_column(:address).of_type(:string) }
  
  it { should have_and_belong_to_many :users }
  it { should belong_to :franchise }
  it { should have_many :leads }
  it { should have_many :vouchers }
  
  # subject { described_class.new }
  
  # describe '.near' do
  #   let(:lead) { create(:lead) }
  #   before do
  #     Unity.any_instance.stub(:geocode).and_return([1,1]) 
  #     unities = 3.times.map { create(:unity) }
  #   end
  #   
  #   it 'returns unities near specific location' do
  #     # subject.near
  #     Unity.near(lead)
  #   end
  # end
end