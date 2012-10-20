class UserMailer < ActionMailer::Base
  def payment_processed(voucher)
    @voucher = voucher
    subject = "Pagamento realizado"
    mail(:to => voucher.lead.email, :subject => subject)
  end
end