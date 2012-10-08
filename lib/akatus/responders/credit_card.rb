class Akatus::Responders::CreditCard
  def self.process(voucher, response)

  	parsed = Nokogiri.parse(response.body)

  	payment_status = parsed.css('status').first

  	logger ||= Logger.new(STDOUT)
  	logger.info ""
  	logger.info "Parsed response body"
  	logger.info parsed.inspect
  	logger.info ""
  	logger.info "Payment status"
  	logger.info payment_status

    #     if payment_status
    #       lead.set(:payment_status, payment_status.text) 
    #   lead.set(:matriculado, true) && lead.set(:prospectado, false) if payment_status.text == "Aprovado"
    # end
  end
end