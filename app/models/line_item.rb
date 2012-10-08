class LineItem < ActiveRecord::Base
  belongs_to :voucher
  belongs_to :product
  
  attr_accessible :quantity
  
  before_validation :copy_price
  before_save :update_voucher
  before_destroy :update_voucher
  
  def copy_price
    self.price = product.price
  end
  
  def amount
    self.price * self.quantity
  end
  alias total amount
  
  private
  
  def update_voucher
    voucher.update!
  end
end