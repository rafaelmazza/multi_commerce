class LineItem < ActiveRecord::Base
  belongs_to :voucher
  belongs_to :product
  
  before_validation :copy_price
  
  def copy_price
    self.price = product.price
  end
end