module MultiCommerce
  class Geocoder
    def self.perform
      Unity.not_geocoded.each do |unity|
        unity.geocode
        unity.save
      end
    end
    
    def self.update_geolocations
      csv_path = "#{Rails.root}/lib/csv/geolocations.csv"
      CSV.open(csv_path).each do |row|
        zipcode, latitude, longitude = row
        # code = "%08d" % code.to_i
        zipcode = zipcode.gsub(/-/, '')
        p "#{zipcode} || #{latitude} || #{longitude}"
        # unity = Unity.find_by_code(code)
        unity = Unity.search_by_address(zipcode).first
        if unity
          unity.latitude = latitude
          unity.longitude = longitude
          unity.save
        end
      end
    end
  end
end