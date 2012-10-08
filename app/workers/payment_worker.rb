class PaymentWorker
  include Sidekiq::Worker
  
  def perform(voucher_id, credit_card)
    Akatus::Payment.perform(voucher_id, credit_card)
  end
end