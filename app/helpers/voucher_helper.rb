# encoding: UTF-8
module VoucherHelper
  def voucher_total
    current_franchise.products.sum(&:price)
  end
  
  def label_class(status)
    case status
    when 'Aprovado'
      'label-success'
    when 'Cancelado'
      'label-important'
    when 'Aguardando Pagamento'
      'label-warning'
    when 'Em análise'
      'label-info'    
    end
  end
end