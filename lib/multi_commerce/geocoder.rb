module MultiCommerce
  class Geocoder
    def self.perform
      Unity.not_geocoded.each do |unity|
        unity.geocode
        unity.save
      end
    end
  end
end