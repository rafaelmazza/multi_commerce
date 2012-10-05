class Akatus::Xml
  def initialize(lead, conf)
    @lead, @conf = lead, conf
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
      hash[:nome] = @lead.name
      hash[:email] = @lead.email
      hash[:enderecos] = endereco
      hash[:telefones] = telefone
    end
  end

  def transacao
    {
      desconto_total: @lead.course.discount,
      peso_total: 0,
      frete_total: 0,
      moeda: "BRL",
      referencia: @lead.id.to_s,
      meio_de_pagamento: @lead.payment
    }.merge(cartao)
  end

  def cartao
    return {} if @lead.payment == "boleto"

    {
      numero: @lead.credit_card.number,
      parcelas: @lead.credit_card.installments,
      codigo_de_seguranca: @lead.credit_card.security_code,
      expiracao: @lead.credit_card.expiration_date,
      portador: { 
        nome: @lead.credit_card.owners_name,
        cpf: @lead.cpf,
        telefone: lead_phone
      }
    }
  end

  def produtos
    [{
        codigo: @lead.course.id.to_s,
        descricao: @lead.course.name,
        quantidade: 1,
        preco: @lead.course.value,
        peso: 0,
        frete: 0,
        desconto: @lead.course.discount
    }]
  end

  def endereco
    { endereco: {
      tipo: "entrega",
      logradouro: @lead.address.street,
      complemento: @lead.address.complement,
      numero: @lead.address.number,
      bairro: @lead.address.district,
      cidade: @lead.address.city,
      estado: @lead.address.state,
      pais: @lead.address.country,
      cep: @lead.address.zipcode
    } }
  end

  def telefone
    { telefone: {tipo: "celular", numero: lead_phone} }
  end

  def lead_phone
    @lead.phone_code + @lead.phone
  end
end
