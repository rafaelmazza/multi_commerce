namespace :email_reports do
  desc 'Daily leads email report'
  task :daily_leads => :environment do
    d = Date.new(2012, 10, 22)
    report = {}
    Franchise.all.each do |franchise|
      report[franchise.name] = {}
      franchise.leads.where(["created_at >= ? AND created_at < ?", d.beginning_of_day, (d+1).end_of_day]).group(:campaign_id).count.each_pair do |campaign_id, total|
        campaign = Campaign.find(campaign_id) if campaign_id
        if campaign
          report[franchise.name][campaign.name] = total
        else
          report[franchise.name]['direto'] = total
        end
      end  
    end        
    ReportsMailer.daily_leads_total_report(report).deliver
  end
  
  desc 'Weekly leads email report'
  task :weekly_leads => :environment do
    report = {}
    Franchise.all.each do |franchise|
      report[franchise.name] = {}
      ((Date.today - 7)..Date.yesterday).each do |d|
        # report[franchise.name][d] = {}
        campaigns = {}
        franchise.leads.where(["created_at >= ? AND created_at < ?", d.to_time, (d+1).to_time]).group(:campaign_id).count.each_pair do |campaign_id, total|
          campaign = Campaign.find(campaign_id) if campaign_id
          campaigns.merge!((campaign ? "#{campaign.name}" : "direto") => total)
          report[franchise.name][d] = campaigns
        end
      end
    end
    ReportsMailer.weekly_leads_total_report(report).deliver
  end
end