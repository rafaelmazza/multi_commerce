module VoucherHelper
  def voucher_total
    current_franchise.products.sum(&:price)
  end
end