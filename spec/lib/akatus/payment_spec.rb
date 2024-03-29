require 'spec_helper'

describe Akatus::Payment do
  describe ".perform" do
    let(:voucher) { create :voucher }
    let(:barcode) { mock.as_null_object }
    let(:response) { mock body: 'response body' }
    
    let(:conf) do
      { "akatus" => { "uri" => "uri" } }
    end

    before do
      YAML.stub(:load_file).and_return conf
    end
    
    context 'when paying with credit card' do
      let(:credit_card) { mock.as_null_object }
      
      it "should parse voucher to xml and send to akatus" do
        xml_parser = mock :xml_parser, generate: "xml"
        Akatus::Xml.should_receive(:new).with(voucher, conf).and_return xml_parser

        Akatus::Request.should_receive(:post).with("uri", "xml").and_return(response)

        described_class.perform voucher
      end
    end

    # context "when payment format is barcode" do
    #   it "should pass response to barcode responder" do
    #     voucher.payment_method = "boleto"
    #     xml_mock = mock generate: "barcode_request"
    #     Akatus::Xml.stub(:new).and_return xml_mock
    #     Akatus::Request.stub(:post).with("uri", "barcode_request").and_return(response)
    # 
    #     # Akatus::Responders::Barcode.should_receive("process").with "barcode_reponse"
    #     Akatus::Responders::Barcode.should_receive("process").with voucher, response
    # 
    #     described_class.perform voucher
    #   end
    # end
    
    # context "when payment format is barcode" do
    #   it "should pass response to barcode responder" do
    #     stub_request(:post, 'uri').to_timeout
    #     voucher.payment_method = "cartao_visa"
    #     xml_mock = mock generate: "barcode_request"
    #     Akatus::Xml.stub(:new).and_return xml_mock
    #     Akatus::Request.stub(:post).with("uri", "barcode_request").and_return(response)
    #         
    #     Akatus::Responders::CreditCard.should_not_receive("process").with voucher, response
    # 
    #     expect { described_class.perform voucher }.to raise_error(Akatus::ConnectionFailed)
    #   end
    # end
  end
end
