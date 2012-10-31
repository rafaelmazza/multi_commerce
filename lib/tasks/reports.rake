namespace :email_reports do
  desc 'Daily leads email report'
  task :daily_leads => :environment do
    # d = Date.new(2012, 10, 22)
    # report = {}
    # Franchise.all.each do |franchise|
    #   report[franchise.name] = {}
    #   franchise.leads.where(["created_at >= ? AND created_at < ?", d.beginning_of_day, (d+1).end_of_day]).group(:campaign_id).count.each_pair do |campaign_id, total|
    #     campaign = Campaign.find(campaign_id) if campaign_id
    #     campaigns.merge!((campaign ? "#{campaign.name}" : "direto") => total)
    #   end  
    # end
    # report = generate_report(Date.yesterday) # TODO: uncomment production
    # yesterday = Date.yesterday
    yesterday = Date.new(2012, 10, 22)
    report = generate_report(yesterday)
    ReportsMailer.daily_leads_total_report(report).deliver
  end
  
  desc 'Weekly leads email report'
  task :weekly_leads => :environment do
    # report = {}
    # Franchise.all.each do |franchise|
    #   report[franchise.name] = {}
    #   ((Date.today - 7)..Date.yesterday).each do |d|
    #     # report[franchise.name][d] = {}
    #     campaigns = {}
    #     franchise.leads.where(["created_at >= ? AND created_at < ?", d.to_time, (d+1).to_time]).group(:campaign_id).count.each_pair do |campaign_id, total|
    #       campaign = Campaign.find(campaign_id) if campaign_id
    #       campaigns.merge!((campaign ? "#{campaign.name}" : "direto") => total)
    #       report[franchise.name][d] = campaigns
    #     end
    #   end
    # end
    report = generate_report((Date.today - 7), Date.today)
    ReportsMailer.weekly_leads_total_report(report).deliver
  end
  
  desc 'Monthly leads email report'
  task :monthly_leads => :environment do
    # today = Date.today
    today = Date.new(2012, 11, 1)
    report = generate_report((today << 1), today - 1)
    # report = {}
    # Franchise.all.each do |franchise|
    #   p franchise.name
    #   # ((Date.today << 1)...Date.today).each do |d|
    #   report[franchise.name] = {}
    #   ((Date.tomorrow << 1)...Date.tomorrow).each do |d|
    #     report[franchise.name][d] = {}
    #     campaigns = {}
    #     franchise.leads.where(created_at: d.beginning_of_day..d.end_of_day).group(:campaign_id).count.each_pair do |campaign_id, total|
    #       campaign = Campaign.find(campaign_id) if campaign_id
    #       campaigns.merge!((campaign ? "#{campaign.name}" : "direto") => total)
    #       report[franchise.name][d] = campaigns
    #     end
    #   end
    # end
    # p report
    ReportsMailer.monthly_leads_total_report(report).deliver
  end
  
  def generate_report(from, to=nil)
    to = from if to.nil?
    report = {}
    Franchise.all.each do |franchise|
      report[franchise.name] = {}
      (from..to).each do |d|
        report[franchise.name][d] = {}
        campaigns = {}
        franchise.leads.where(created_at: d.beginning_of_day..d.end_of_day).group(:campaign_id).count.each_pair do |campaign_id, total|
          campaign = Campaign.find(campaign_id) if campaign_id
          campaigns.merge!((campaign ? "#{campaign.name}" : "direto") => total)
          report[franchise.name][d] = campaigns
        end
      end
    end
    report
  end
end