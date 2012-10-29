class ReportsMailer < ActionMailer::Base
  default :from => 'do-not-reply@cafeazulhost.com.br'
  
  def daily_leads_total_report(report)
    @report = report
    subject = 'Relatorio Semanal'
    mail(:to => 'rafael@cafeazul.com.br', :subject => subject)
  end
  
  def weekly_leads_total_report(report)
    @report = report
    subject = 'Relatorio Semanal'
    mail(:to => 'rafael@cafeazul.com.br', :subject => subject)
  end
end