class Akatus::Request
  def self.post(uri, xml)
    connection(uri).post do |request|
      request.body = xml
    end
  end

  private

  def self.connection(uri)
    Faraday.new(:url => uri) do |faraday|
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end
  end
end