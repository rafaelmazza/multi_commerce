require 'yaml'

class Akatus::ConnectionFailed < StandardError; end
class Akatus::PaymentFailed < StandardError; end

class Akatus::Payment
  # attr_accessible :status, :description, :akatus_transaction, :url
  
  # belongs_to :voucher
  
  # def success?
  #   status? && status != 'erro'
  # end
  
  # @queue = :payment
  # RESPONDERS = { 
  #               "boleto"        => Akatus::Responders::Barcode,
  #               "cartao_visa"   => Akatus::Responders::CreditCard,
  #               "cartao_master" => Akatus::Responders::CreditCard
  #              }

  def self.perform(voucher)

    xml_parser = Akatus::Xml.new voucher, conf
    xml = xml_parser.generate

    logger ||= Logger.new(STDOUT)
    
    logger.info ""
    logger.info "XML we're posting:"
    logger.info ""
    logger.info xml.inspect
    
    logger.info ""
    logger.info "Our post and raw akatus response:"
    logger.info ""
    
    begin
      response = Akatus::Request.post conf["akatus"]["uri"], xml
      # responder voucher.payment_method, voucher, response
      process(voucher, response)
      UserMailer.delay.payment_processed(voucher)
    rescue Faraday::Error::ConnectionFailed => error
      raise Akatus::ConnectionFailed, I18n.t('akatus.errors.messages.connection_failed')
    rescue Faraday::Error::TimeoutError => error
      raise Akatus::ConnectionFailed, I18n.t('akatus.errors.messages.time_out')
    rescue Akatus::PaymentFailed => error
      raise error
    end      
      
    p 'response'
    p response.inspect
    
    logger.info ""
    logger.info "Full response object:"
    logger.info ""
    logger.info response.inspect
    
    logger.info ""
    logger.info "Akatus xml in response body:"
    logger.info ""
    logger.info response.body.inspect
    logger.info ""
  end

  private
  
  def self.process(voucher, response)
  	parsed = Nokogiri.parse(response.body)
  	
    logger ||= Logger.new(STDOUT)
    logger.info ""
    logger.info "Parsed response body"
    logger.info parsed.inspect  	
  	
  	error_description = parsed.xpath('//descricao').try(:text)
    raise Akatus::PaymentFailed, error_description and return if not error_description.blank?
  	
    voucher.status = parsed.xpath('//status').try(:text)
    voucher.transaction_key = parsed.xpath('//transacao').try(:text)
    voucher.payment_url = parsed.xpath('//url_retorno').try(:text)
    voucher.save
    voucher
  end

  # def self.responder(payment_method, voucher, response)
  #   RESPONDERS[payment_method].process(voucher, response)
  # end

  def self.conf
    YAML.load_file conf_file
  end

  def self.conf_file
    Rails.root.join "config", "akatus.yml"
  end
end
