class SalesChartCell < Cell::Rails
  include Devise::Controllers::Helpers

  def show
    @sales = current_user.vouchers.where('vouchers.status IS NOT NULL').group('vouchers.status').sum(:total)
    @data = @sales.each_pair.map {|label, total| {status: label, total: total}}
    # @data = @sales.each_pair.map {|label, total| {status: (label ? label : 'Gratuito'), total: total}}
    render if not @data.empty?
  end

end
