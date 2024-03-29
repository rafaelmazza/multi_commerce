# encoding: UTF-8
require 'spec_helper'

describe MultiCommerce::Parser do
  let(:erp_response) { File.read(Rails.root.join('spec', 'support', 'fixtures', 'unities.xml')) }
  # let(:geocoding) { File.read(Rails.root.join('spec', 'support', 'fixtures', 'geocoding.json')) }
  subject { described_class.new erp_response }
  
  before do
    Franchise.stub find_by_acronym: create(:franchise)
  end
  
  context '#parse' do
    it 'gets unity data and persist' do
      subject.parse
      Unity.first.code.should == "00000003"
    end
    
    it 'creates user for the unity' do
      expect { subject.parse }.to change(User, :count).by(4)
    end
  end
  
  context "#parse_unity" do
    it "should return a formated hash" do
      expected = subject.parse_unity

      expected.first[:code].should == "00000003"
      expected.first[:name].should == "AGUAI"
      expected.first[:email].should == "aguai@wizard.com.br"
      expected.first[:phone_code].should == "19"
      expected.first[:phone].should == "36611367"
      # expected.first[:address].should == "Rua Valins, 1042, Centro, Aguaí, SP, 13860000"
      expected.first[:address_street].should == "Rua Valins"
      expected.first[:address_number].should == "1042"
      expected.first[:address_district].should == "Centro"
      expected.first[:address_city].should == "Aguaí"
      expected.first[:address_state].should == "SP"
      expected.first[:address_zipcode].should == "13860000"
      expected.first[:franchise_acronym].should == "W"
      expected.first[:status].should == "4"
      expected.first[:situation].should == "1"
    end

    it "should parse unities only with modalidade W" do
      subject.parse_unity.should have(5).items
    end
  end
end