# encoding: UTF-8
require 'spec_helper'

describe Akatus::Xml do
  describe "generate" do

    let(:address) do 
      build :address, 
              street: "Avenida Moema", 
              complement: "Conjunto 65", 
              number: "170", 
              city: "São Paulo", 
              state: "SP", 
              zipcode: "04077-020", 
              district: "Moema" 
    end
    
    let(:lead) do 
      # create :lead_with_products, 
      create :lead, 
                name: "John", 
                email: "john@cafeazul.com.br", 
                address: address 
    end
    
    let(:voucher) do
      create :voucher_with_line_items, lead: lead
    end

    let(:conf) do
      { "akatus" => { "email" => "email@domain.com", "api_key" => "api_key" } }
    end

    subject do
      # akatus_xml = described_class.new lead, conf
      akatus_xml = described_class.new voucher, conf
      Nokogiri::XML akatus_xml.generate
    end

    context "recebedor" do
      before { @node = subject.xpath "//carrinho//recebedor" }

      it "should include api_key" do
        @node.css("api_key").text.should == "api_key"
      end

      it "should include email" do
        @node.css("email").text.should == "email@domain.com"
      end
    end

    context "pagador" do
      before { @node = subject.xpath "//carrinho//pagador" }

      it "should include nome" do
        @node.css("nome").text.should == "John"
      end

      it "should include email" do
        @node.css("email").text.should == "john@cafeazul.com.br"
      end

      context "telefones" do
        before { @phone = @node.xpath "//telefones//telefone" }

        it "should include tipo" do
          @phone.css("tipo").text.should == "celular"
        end

        it "should include numero" do
          @phone.css("numero").text.should == "1150527001"
        end
      end

      context "enderecos" do
        before { @address = @node.xpath "//enderecos//endereco" }

        it "should include tipo" do
          @address.css("tipo").text.should == "entrega"
        end

        it "should include logradouro" do
          @address.css("logradouro").text.should == "Avenida Moema"
        end

        it "should include complemento" do
          @address.css("complemento").text.should == "Conjunto 65"
        end

        it "should include numero" do
          @address.css("numero").text.should == "170"
        end

        it "should include bairro" do
          @address.css("bairro").text.should == "Moema"
        end

        it "should include cidade" do
          @address.css("cidade").text.should == "São Paulo"
        end

        it "should include estado" do
          @address.css("estado").text.should == "SP"
        end

        it "should include pais" do
          @address.css("pais").text.should == "BRA"
        end

        it "should include cep" do
          @address.css("cep").text.should == "04077-020"
        end
      end
    end

    context "produtos" do
      before { @node = subject.xpath("//produtos//produto").first }

      it "should include codigo" do
        # @node.css("codigo").text.should == lead.course.id.to_s
        @node.css("codigo").text.should == lead.id.to_s
      end

      it "should include descricao" do
        # @node.css("descricao").text.should == lead.course.name
        @node.css("descricao").text.should == lead.name
      end

      it "should include quantidade" do
        @node.css("quantidade").text.should == "1"
      end

      it "should include preco" do
        @node.css("preco").text.should == "21.99"
      end

      it "should include peso" do
        @node.css("peso").text.should == "0"
      end

      it "should include frete" do
        @node.css("frete").text.should == "0"
      end

      it "should include desconto" do
        @node.css("desconto").text.should == "0"
      end
    end

    context "transacao" do
      before { @node = subject.xpath "//carrinho//transacao" }

      it "should include desconto_total" do
        @node.css("desconto_total").text.should == "0.0"
      end

      it "should include peso_total" do
        @node.css("peso_total").text.should == "0"
      end

      it "should include frete_total" do
        @node.css("frete_total").text.should == "0"
      end

      it "should include moeda" do
        @node.css("moeda").text.should == "BRL"
      end

      it "should include referencia" do
        @node.css("referencia").text.should == lead.id.to_s
      end

      it "should include meio_de_pagamento" do
        @node.css("meio_de_pagamento").text.should == "boleto"
      end
    end
  end
end
