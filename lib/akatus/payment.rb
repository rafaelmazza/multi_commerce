require 'yaml'

class Akatus::Payment
  # include ActionView::Helpers::NumberHelper
  
  def self.perform(voucher)

    xml_parser = Akatus::Xml.new voucher, conf
    xml = xml_parser.generate

    # logger ||= Logger.new(STDOUT)
    # 
    # logger.info ''
    # logger.info 'XML we're posting:'
    # logger.info ''
    # logger.info xml.inspect
    # 
    # logger.info ''
    # logger.info 'Our post and raw akatus response:'
    # logger.info ''
    
    begin
      response = Akatus::Request.post conf['akatus']['uri'], xml
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
      
    # p 'response'
    # p response.inspect
    # 
    # logger.info ''
    # logger.info 'Full response object:'
    # logger.info ''
    # logger.info response.inspect
    # 
    # logger.info ''
    # logger.info 'Akatus xml in response body:'
    # logger.info ''
    # logger.info response.body.inspect
    # logger.info ''
  end
  
  def self.installments(amount, payment_method)
    uri = URI(conf['akatus']['installments_simulation_uri'])
    params = { 
      :email => conf['akatus']['email'],
      :amount => amount.to_s,
      :payment_method => payment_method,
      :api_key => conf['akatus']['api_key']
    }
    uri.query = URI.encode_www_form(params)
    response = Net::HTTP.start(uri.host, use_ssl: true) { |http| http.get uri.request_uri }
    response.body
  end

  private
  
  def self.process(voucher, response)
  	parsed = Nokogiri.parse(response.body)
  	
    # logger ||= Logger.new(STDOUT)
    # logger.info ''
    # logger.info 'Parsed response body'
    # logger.info parsed.inspect    
  	
  	error_description = parsed.xpath('//descricao').try(:text)
    raise Akatus::PaymentFailed, error_description and return if not error_description.blank?
  	
    voucher.status = parsed.xpath('//status').try(:text)
    voucher.transaction_key = parsed.xpath('//transacao').try(:text)
    voucher.payment_url = parsed.xpath('//url_retorno').try(:text)
    voucher.save
    voucher
  end

  def self.conf
    YAML.load_file conf_file
  end

  def self.conf_file
    Rails.root.join 'config', 'akatus.yml'
  end
end

class Akatus::ConnectionFailed < StandardError; end
class Akatus::PaymentFailed < StandardError; end