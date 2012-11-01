class UserMailer < ActionMailer::Base
  default :from => 'Leads <do-not-reply@cafeazulhost.com.br>'
  
  def payment_processed(voucher)
    @voucher = voucher
    subject = "Pagamento realizado"
    mail(:to => voucher.lead.email, :subject => subject)
  end
  
  def payment_approved(voucher)
    @voucher = voucher
    subject = "Pagamento aprovado"
    mail(:to => voucher.lead.email, :subject => subject)
  end  
end