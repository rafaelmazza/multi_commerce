class Akatus::Xml
  def initialize(voucher, credit_card, conf)
    @voucher, @credit_card, @conf = voucher, credit_card, conf
  end

  def generate
    {}.tap do |hash|
      hash[:recebedor] = recebedor
      hash[:pagador] = pagador
      hash[:produtos] = produtos
      hash[:transacao] = transacao
    #end.to_xml root: "carrinho", dasherize: false, skip_instruct: true, skip_types: true
    end.to_xml root: "carrinho", dasherize: false, skip_types: true
  end

  private

  def recebedor
    { "api_key" => @conf["akatus"]["api_key"], email: @conf["akatus"]["email"] }
  end

  def pagador
    {}.tap do |hash|
      hash[:nome] = @voucher.lead.name
      hash[:email] = @voucher.lead.email
      hash[:enderecos] = endereco
      hash[:telefones] = telefone
    end
  end

  def transacao
    { desconto_total: "0.00",
      peso_total: 0,
      frete_total: 0,
      moeda: "BRL",
      referencia: @voucher.id,
      meio_de_pagamento: @voucher.payment_method
    }.merge(cartao)
  end

  def cartao
    return {} if @voucher.payment_method == "boleto"

    { numero: @credit_card['number'],
      parcelas: @credit_card['installments'],
      codigo_de_seguranca: @credit_card['cvv'],
      expiracao: @credit_card['expiration_date'],
      portador: { 
        nome: @credit_card['card_holder_name'],
        cpf: @voucher.lead.cpf.gsub(/\D/, ''),
        telefone: lead_phone
      }
    }

    # { numero: @voucher.lead.credit_card[:number],
    #   parcelas: @voucher.lead.credit_card[:installments],
    #   codigo_de_seguranca: @voucher.lead.credit_card[:cvv],
    #   expiracao: @voucher.lead.credit_card[:expiration_date],
    #   portador: { 
    #     nome: @voucher.lead.credit_card[:card_holder_name],
    #     cpf: @voucher.lead.cpf.gsub(/\D/, ''),
    #     telefone: lead_phone
    #   }
    # }    
    # { numero: @voucher.lead.credit_card.number,
    #   parcelas: @voucher.lead.credit_card.installments,
    #   codigo_de_seguranca: @voucher.lead.credit_card.cvv,
    #   expiracao: @voucher.lead.credit_card.expiration_date,
    #   portador: { 
    #     nome: @voucher.lead.credit_card.card_holder_name,
    #     cpf: @voucher.lead.cpf.gsub(/\D/, ''),
    #     telefone: lead_phone
    #   }
    # }
  end

  def produtos
    @voucher.line_items.map do |line_item|
      { codigo: line_item.product.id,
        descricao: line_item.product.description,
        quantidade: line_item.quantity,
        preco: "%8.2f" % line_item.price,
        peso: 0,
        frete: 0,
        desconto: "0.00"
      }
    end
  end

  def endereco
    { endereco: {
      tipo: "entrega",
      logradouro: @voucher.lead.address.street,
      complemento: @voucher.lead.address.complement,
      numero: @voucher.lead.address.number,
      bairro: @voucher.lead.address.district,
      cidade: @voucher.lead.address.city,
      estado: @voucher.lead.address.state,
      pais: @voucher.lead.address.country,
      cep: @voucher.lead.address.zipcode.gsub(/\D/, '')
    } }
  end

  def telefone
    { telefone: {tipo: "celular", numero: lead_phone} }
  end

  def lead_phone
    @voucher.lead.phone_code + @voucher.lead.phone
  end
end
