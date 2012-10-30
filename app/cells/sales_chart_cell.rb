class SalesChartCell < Cell::Rails
  include Devise::Controllers::Helpers

  def show
    p 'CHART'
    p current_user.vouchers.inspect
    @sales = current_user.vouchers.group('vouchers.status').sum(:total)
    @data = @sales.each_pair.map {|label, total| {status: label, total: total}}
    render if not @data.empty?
  end

end
