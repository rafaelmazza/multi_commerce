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

    voucher.update_attribute(:status, payment_status.text) if payment_status
  end
end