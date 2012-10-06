class Akatus::Xml
  # def initialize(lead, conf)
  #   @lead, @conf = lead, conf
  # end  
  def initialize(voucher, conf)
    @voucher, @conf = voucher, conf
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
    {
      desconto_total: 0.0,
      peso_total: 0,
      frete_total: 0,
      moeda: "BRL",
      referencia: @voucher.id.to_s,
      meio_de_pagamento: @voucher.payment_method
    }#.merge(cartao)
  end

  # def cartao
  #   return {} if @voucher.payment_method == "boleto"
  # 
  #   {
  #     numero: @voucher.lead.credit_card.number,
  #     parcelas: @voucher.lead.credit_card.installments,
  #     codigo_de_seguranca: @voucher.lead.credit_card.security_code,
  #     expiracao: @voucher.lead.credit_card.expiration_date,
  #     portador: { 
  #       nome: @voucher.lead.credit_card.owners_name,
  #       cpf: @voucher.lead.cpf,
  #       telefone: lead_phone
  #     }
  #   }
  # end

  def produtos
    [{
        # codigo: @lead.course.id.to_s,
        codigo: @voucher.id.to_s,
        # descricao: @lead.course.name,
        descricao: @voucher.lead.name,
        quantidade: 1,
        # preco: @lead.course.value,
        preco: @voucher.total,
        peso: 0,
        frete: 0,
        desconto: 0
    }]
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
      cep: @voucher.lead.address.zipcode
    } }
  end

  def telefone
    { telefone: {tipo: "celular", numero: lead_phone} }
  end

  def lead_phone
    @voucher.lead.phone_code + @voucher.lead.phone
  end
end
