require 'net/http'

module Multicommerce
  WSURL = "http://www.mh1.com.br/wsunidades/wsClientes.asmx/getClientes?codParceiro=SerraAzul"

  class UnitiesImporter
    def self.perform
      parser = Parser.new RestClient.get(WSURL)
      parser.parse
    end
  end
end
