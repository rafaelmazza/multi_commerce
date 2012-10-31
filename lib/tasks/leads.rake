namespace :leads do
  desc 'Subscribe incomplete leads'
  task :subscribe => :environment do
    Lead.incomplete.each do |lead|
      nearest_unities = lead.franchise.unities.nearby(lead)
      if nearest_unities
        unity = nearest_unities.first
        lead.subscribe(unity) if unity
      end
    end
  end
end