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
      create :lead, 
                name: "John", 
                email: "john@cafeazul.com.br"
    end
    
    let(:voucher) do
      create :voucher_with_line_items, lead: lead, address: address
    end

    let(:conf) do
      { "akatus" => { "email" => "email@domain.com", "api_key" => "api_key" } }
    end

    subject do
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
          @address.css("cep").text.should == "04077020"
        end
      end
    end

    context "produtos" do
      before { @nodes = subject.xpath("//produtos//produto") }

      it "includes codigo" do
        voucher.line_items.each_with_index do |line_item, index|
          @node = @nodes[index]
          @node.css("codigo").text.should == line_item.product.id.to_s
        end        
      end
      
      it "includes descricao" do
        voucher.line_items.each_with_index do |line_item, index|
          @node = @nodes[index]
          @node.css("descricao").text.should == line_item.product.description
        end
      end

      it "includes quantidade" do
        voucher.line_items.each_with_index do |line_item, index|
          @node = @nodes[index]
          @node.css("quantidade").text.should == line_item.quantity.to_s
        end        
      end
      
      it "includes preco" do
        voucher.line_items.each_with_index do |line_item, index|
          @node = @nodes[index]
          @node.css("preco").text.should == line_item.price.to_s
        end        
      end

      it "includes peso" do
        voucher.line_items.each_with_index do |line_item, index|
          @node = @nodes[index]
          @node.css("peso").text.should == "0"
        end        
      end
      
      it "includes frete" do
        voucher.line_items.each_with_index do |line_item, index|
          @node = @nodes[index]
          @node.css("frete").text.should == "0"
        end        
      end

      it "includes desconto" do
        voucher.line_items.each_with_index do |line_item, index|
          @node = @nodes[index]
          @node.css("desconto").text.should == "0"
        end        
      end
    end

    context 'when boleto' do
      context "transacao" do
        before { @node = subject.xpath "//carrinho//transacao" }

        it "should include desconto_total" do
          @node.css("desconto_total").text.should == "0.00"
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
          @node.css("referencia").text.should == voucher.id.to_s
        end

        it "should include meio_de_pagamento" do
          @node.css("meio_de_pagamento").text.should == "boleto"
        end
      end
    end
    
    context 'when visa' do
      let(:credit_card) do
        CreditCard.new card_holder_name: 'JOHN DOO', number: '1234', security_code: '111', installments: 1, expiration_date: '05/2013'
        # {card_holder_name: 'JOHN DOO', number: '1234', cvv: '111', installments: 1, expiration_date: '2013-01-01'}
      end
      
      let(:lead) do 
        create :lead, 
                  name: "John", 
                  email: "john@cafeazul.com.br"
                  # cpf: '980.106.539-77'
                  # address: address,
                  # credit_card: credit_card
      end
      
      let(:voucher) do
        create :voucher_with_line_items, payment_method: 'cartao_visa', lead: lead, address: address, credit_card: credit_card, cpf: '98010653977'
      end
      
      context "transacao" do
        before do
          @node = subject.xpath "//carrinho//transacao" 
        end
        
        it 'includes numero' do
          @node.css('numero').text.should == '1234'
        end
        
        it 'includes parcelas' do
          @node.css('parcelas').text.should == "1"
        end
        
        it 'includes codigo_de_seguranca' do
          @node.css('codigo_de_seguranca').text.should == '111'
        end
                
        it 'includes expiracao' do
          @node.css('expiracao').text.should == '05/2013'
        end

        it "should include desconto_total" do
          @node.css("desconto_total").text.should == "0.00"
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
          @node.css("referencia").text.should == voucher.id.to_s
        end

        it "should include meio_de_pagamento" do
          @node.css("meio_de_pagamento").text.should == "cartao_visa"
        end
        
        context 'portador' do
          before { @node = subject.xpath "//carrinho//transacao//portador" }
          
          it 'includes nome' do
            @node.css("nome").text.should == "JOHN DOO"
          end

          it 'includes cpf' do
            @node.css("cpf").text.should == "98010653977"
          end
          
          it 'includes telefone' do
            @node.css("telefone").text.should == "1150527001"
          end
        end
      end
    end
  end
end
