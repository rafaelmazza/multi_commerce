require 'net/http'

module MultiCommerce
  WSURL = "http://0.0.0.0:4567/unities"

  class Importer
    def self.perform
      parser = Parser.new RestClient.get(WSURL)
      parser.parse
    end
  end
end