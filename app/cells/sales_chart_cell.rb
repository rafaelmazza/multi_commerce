class SalesChartCell < Cell::Rails
  include Devise::Controllers::Helpers

  def show
    @sales = current_user.vouchers.group('vouchers.status').sum(:total)
    @data = @sales.each_pair.map {|label, total| {status: label, total: total}}
    render
  end

end
