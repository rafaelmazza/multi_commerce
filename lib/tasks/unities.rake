namespace :unities do
  desc 'Remind unities to prospect remaining leads'
  task :send_reminder => :environment do
    Lead.not_prospected.group_by(&:unity).each do |unity, leads|
      UnityMailer.reminder(unity, leads).deliver if unity
    end
  end
end