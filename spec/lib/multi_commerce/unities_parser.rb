# encoding: UTF-8
require 'spec_helper'

describe MultiCommerce::UnitiesParser do
  let(:erp_response) { File.read(Rails.root.join('spec', 'support', 'fixtures', 'unities.xml')) }
  # let(:geocoding) { File.read(Rails.root.join('spec', 'support', 'fixtures', 'geocoding.json')) }
  subject { described_class.new erp_response }
  
  context '#parse' do
    it 'gets unity data and persist' do
      subject.parse
      Unity.first.code.should == "00000003"
    end
  end
  
  context "#parse_unity" do
    it "should return a formated hash" do
      expected = subject.parse_unity

      expected.first[:code].should == "00000003"
      expected.first[:name].should == "AGUAI"
      expected.first[:email].should == "aguai@wizard.com.br"
      expected.first[:phone].should == "19 3661 1367"
      # expected.first[:address].should == "Rua Valins, 1042, Centro, Aguaí, SP"
      expected.first[:address].should == "Rua Valins, Nº. 1042 - Centro - Aguaí/SP - 13860000"
      expected.first[:franchise_acronym].should == "W"
      expected.first[:status].should == "4"
      expected.first[:situation].should == "1"
    end

    it "should parse unities only with modalidade W" do
      subject.parse_unity.should have(2).items
    end
  end
end