class Voucher < ActiveRecord::Base
  belongs_to :unity
  belongs_to :lead
  has_many :line_items
  
  attr_accessible :used_at, :unity_id
  
  before_create :generate_code
  
  def use
    update_attributes used_at: Time.now
  end

  private

  def generate_code
    self.code = MultiCommerce::VoucherGenerator.generate
  end
end