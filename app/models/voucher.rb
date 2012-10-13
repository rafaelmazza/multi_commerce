class Voucher < ActiveRecord::Base
  belongs_to :unity
  belongs_to :lead
  belongs_to :timetable
  has_many :line_items
  
  attr_accessible :used_at, :unity_id, :payment_method, :total, :timetable_id
  
  before_create :generate_code
  
  def use
    update_attributes used_at: Time.now
  end
  
  # def total
  #   self.total = line_items.map(&:price).sum
  # end
  
  def add_product(product, quantity=1)
    current_item = contains?(product)
    if current_item.nil?
      current_item = LineItem.new(quantity: quantity)
      current_item.product = product
      self.line_items << current_item      
    end
    current_item
  end
  
  def contains?(product)
    line_items.detect { |li| li.product.id == product.id }
  end
  
  def update!
    self.total = line_items.map(&:amount).sum
    save # TODO: it should be here?
  end

  private

  def generate_code
    self.code = MultiCommerce::VoucherGenerator.generate
  end
end