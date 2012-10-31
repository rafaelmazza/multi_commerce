class UnityMailer < ActionMailer::Base
  default :from => 'do-not-reply@cafeazulhost.com.br'
  
  def reminder(unity, leads)
    @unity, @leads = unity, leads
    subject = 'Existem leads a serem prospectados'
    # mail(:to => 'rafael@cafeazul.com.br', :subject => subject)
    mail(:to => unity.email, :subject => subject)
  end
end