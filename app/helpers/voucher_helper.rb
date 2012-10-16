module VoucherHelper
  def voucher_total
    number_to_currency current_franchise.products.sum(&:price)
  end
end