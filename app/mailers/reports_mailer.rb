class ReportsMailer < ActionMailer::Base
  default :from => 'Leads <do-not-reply@cafeazulhost.com.br>'

  def daily_leads_total_report(report)
    @report = report
    @subject = 'Leads do dia'
    mail(to: 'rafael@cafeazul.com.br', subject: @subject, template_name: 'report')
  end
  
  def weekly_leads_total_report(report)
    @report = report
    @subject = 'Leads semanais'
    mail(to: 'rafael@cafeazul.com.br', subject: @subject, template_name: 'report')
  end
  
  def monthly_leads_total_report(report)
    @report = report
    @subject = 'Leads mensais - MultiCommerce'
    mail(to: 'rafael@cafeazul.com.br', subject: @subject, template_name: 'report')
  end
end