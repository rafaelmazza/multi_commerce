require 'yaml'

class Akatus::Payment < ActiveRecord::Base
  attr_accessible :status, :description, :akatus_transaction, :url
  
  belongs_to :voucher
  
  def success?
    status? && status != 'erro'
  end
  
  @queue = :payment
  RESPONDERS = { 
                "boleto"        => Akatus::Responders::Barcode,
                "cartao_visa"   => Akatus::Responders::CreditCard,
                "cartao_master" => Akatus::Responders::CreditCard
               }

  def self.perform(voucher)
    # voucher = Voucher.find voucher_id

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

    response = Akatus::Request.post conf["akatus"]["uri"], xml

    logger.info ""
    logger.info "Full response object:"
    logger.info ""
    logger.info response.inspect
    
    logger.info ""
    logger.info "Akatus xml in response body:"
    logger.info ""
    logger.info response.body.inspect
    logger.info ""

    responder voucher.payment_method, voucher, response
  end

  private

  def self.responder(payment_method, voucher, response)
    RESPONDERS[payment_method].process(voucher, response)
  end

  def self.conf
    YAML.load_file conf_file
  end

  def self.conf_file
    Rails.root.join "config", "akatus.yml"
  end
end
