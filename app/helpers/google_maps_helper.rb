module GoogleMapsHelper
  GOOGLE_MAPS_STATIC = "http://maps.google.com/maps/api/staticmap"
  
  def static_map_url(model)
    GOOGLE_MAPS_STATIC + "?zoom=15&size=177x105&maptype=roadmap&sensor=false&markers=color:blue#{escaped_address(model)}" if mappable?(model)
  end

  def external_directions_map_url(model, starting_address)
    "http://maps.google.com/maps?saddr=#{URI.escape(starting_address)}&daddr=#{URI.escape(model.address)}" if mappable?(model)
  end

  def external_map_url(model)
    "https://maps.google.com/maps?zoom=16&q=#{URI.escape(model.address)}" if mappable?(model)
  end
  
  private
  
  def mappable?(model)
    model.respond_to?(:address) and not model.address.blank?
  end

  def escaped_address(model)
    CGI.escape "|" + model.address
  end
end