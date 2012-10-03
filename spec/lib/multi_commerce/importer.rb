require 'spec_helper'

WSURL = "http://www.mh1.com.br/wsunidades/wsClientes.asmx/getClientes?codParceiro=SerraAzul"

describe MultiCommerce::Importer do
  let(:xml) { File.read(Rails.root.join('spec', 'support', 'fixtures', 'unities.xml')) }
  before(:all) do
    # @xml = File.read(Rails.root.join('spec', 'fixtures', 'unities.xml'))
    stub_request(:get, WSURL).to_return body: xml
  end
  
  context '#perform' do
    it 'invoke parser passing unities xml' do
      parser = mock.as_null_object
      MultiCommerce::Parser.stub(:new).with(xml).and_return(parser)
      
      parser.should_receive :parse
      described_class.perform
    end
  end
end