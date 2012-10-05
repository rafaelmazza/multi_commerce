require 'spec_helper'

describe Akatus::Request do
  describe ".post" do
    let(:uri) { "https://dev.akatus.com/api/v1/carrinho.xml" }
    
    it "should send data received by post" do
      stub_request :post, uri

      described_class.post uri, "xml"

      WebMock.should have_requested(:post, uri).with(body: "xml")
    end
  end
end
