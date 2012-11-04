class UnityMailer < ActionMailer::Base
  def reminder(unity, leads)
    @unity, @leads = unity, leads
    subject = 'Existem leads a serem prospectados'
    from = "Leads - #{voucher.franchise.title} <do-not-reply@cafeazulhost.com.br>"
    # mail(:to => 'rafael@cafeazul.com.br', :subject => subject)    
    mail(from: from, to: unity.email, subject: subject)
  end
end