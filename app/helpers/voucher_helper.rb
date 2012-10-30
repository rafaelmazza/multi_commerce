# encoding: UTF-8
module VoucherHelper
  def voucher_total
    current_franchise.products.sum(&:price)
  end
  
  def label_class(status)
    case status
    when 'Aprovado'
      'label label-success'
    when 'Cancelado'
      'label label-important'
    when 'Aguardando Pagamento'
      'label label-warning'
    when 'Em Análise'
      'label label-info'
    when 'Invalidado'
      'label'
    end
  end
end