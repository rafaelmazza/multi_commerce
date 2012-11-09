class UserMailer < ActionMailer::Base
  helper :application
  
  def payment_processed(voucher)
    @voucher = voucher
    from = "#{voucher.franchise.title} <do-not-reply@cafeazulhost.com.br>"
    subject = "#{voucher.franchise.title} - Pedido em processamento"
    mail(from: from, to: voucher.lead.email, subject: subject)
  end
  
  def payment_approved(voucher)
    @voucher = voucher
    from = "#{voucher.franchise.title} <do-not-reply@cafeazulhost.com.br>"
    subject = "#{voucher.franchise.title} - Compra confirmada"
    mail(from: from, to: voucher.lead.email, subject: subject)
  end  
end