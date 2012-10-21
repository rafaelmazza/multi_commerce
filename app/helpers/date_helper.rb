module DateHelper
  def parse_datetime(date, format="%d-%m-%Y")
    DateTime.parse(date).strftime(format) rescue nil
  end
end