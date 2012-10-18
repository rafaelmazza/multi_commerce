class Akatus::Responders::CreditCard
  def self.process(voucher, response)
    payment = voucher.payments.new
    
  	parsed = Nokogiri.parse(response.body)

    # payment_status = parsed.css('status').first
    # 
    # logger ||= Logger.new(STDOUT)
    # logger.info ""
    # logger.info "Parsed response body"
    # logger.info parsed.inspect
    # logger.info ""
    # logger.info "Payment status"
    # logger.info payment_status
    # 
    #     voucher.update_attribute(:status, payment_status.text) if payment_status

    payment.status = parsed.xpath('//status').try(:text)
    payment.description = parsed.xpath('//descricao').try(:text)
    # payment.reference = parsed.xpath('//referencia').try(:text)
    payment.akatus_transaction = parsed.xpath('//transacao').try(:text)
    payment.url = parsed.xpath('//url_retorno').try(:text)
    
    payment.save
    # p payment.inspect
    payment
  end
end