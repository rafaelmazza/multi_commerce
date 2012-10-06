require 'spec_helper'

describe Akatus::Payment do
  describe ".perform" do
    let(:lead) { create :lead }
    let(:barcode) { mock.as_null_obejct }
    let(:conf) do
      { "akatus" => { "uri" => "uri" } }
    end

    before do
      YAML.stub(:load_file).and_return conf
    end

    it "should parse lead to xml and send to akatus" do
      xml_parser = mock :xml_parser, generate: "xml"
      Akatus::Xml.should_receive(:new).with(lead, conf).and_return xml_parser

      Akatus::Request.should_receive(:post).with "uri", "xml"

      described_class.perform lead.id
    end

    context "when payment format is barcode" do
      it "should pass response to barcode responder" do
        lead.payment = "boleto"
        xml_mock = mock generate: "barcode_request"
        Akatus::Xml.stub(:new).and_return xml_mock
        Akatus::Request.stub(:post).with("uri", "barcode_request").and_return "barcode_reponse"

        Akatus::Responders::Barcode.should_receive("process").with "barcode_reponse"

        described_class.perform lead.id
      end
    end
  end
end