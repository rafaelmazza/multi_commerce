require 'yaml'

class Akatus::Payment
  @queue = :payment
  RESPONDERS = { 
                "boleto"        => Akatus::Responders::Barcode,
                "cartao_visa"   => Akatus::Responders::CreditCard,
                "cartao_master" => Akatus::Responders::CreditCard
               }

  def self.perform(lead_id)
    lead = Lead.find lead_id

    xml_parser = Akatus::Xml.new lead, conf
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

    responder lead.payment, lead, response
  end

  private

  def self.responder(payment, lead, response)
    RESPONDERS[payment].process(lead, response)
  end

  def self.conf
    YAML.load_file conf_file
  end

  def self.conf_file
    Rails.root.join "config", "akatus.yml"
  end
end
