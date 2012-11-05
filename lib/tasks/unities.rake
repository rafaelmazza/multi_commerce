namespace :unities do
  desc 'Remind unities to prospect remaining leads'
  task :send_reminder => :environment do
    Lead.not_prospected.group_by(&:unity).each do |unity, leads|
      UnityMailer.reminder(unity, leads).deliver if unity
    end
  end
  
  desc 'Import unitities form ERP'
  task :import => :environment do
    MultiCommerce::Importer.perform
  end
  
  desc 'Geocode unitities'
  task :geocode => :environment do
    MultiCommerce::Geocoder.update_geolocations
    MultiCommerce::Geocoder.perform
  end
end