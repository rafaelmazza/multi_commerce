class Voucher < ActiveRecord::Base
  belongs_to :unity
  belongs_to :lead
  belongs_to :timetable
  has_many :line_items
  has_one :address
  
  attr_accessible :used_at, :unity_id, :payment_method, :total, :timetable_id, :status, :credit_card, :credit_card_attributes, :lead_attributes, :address_attributes, :cpf, :line_item_ids
  
  before_create :generate_code
  
  attr_accessor :credit_card
  
  accepts_nested_attributes_for :address
  
  # after_initialize :build_address, if: lambda { address.nil? }
  after_initialize :build_credit_card
  
  def build_credit_card
    self.credit_card = CreditCard.new
  end
  
  # payment_method_is_credit_card = Proc.new { payment_method != 'boleto' }
  payment_method_is_credit_card = Proc.new { |v| v.payment_method && v.payment_method != 'boleto' }
  after_validation :check_credit_card, if: payment_method_is_credit_card
  
  validates :cpf, presence: true, on: :update, if: payment_method_is_credit_card
  validates :cpf, cpf: true
  
  def check_credit_card
    credit_card.valid? if credit_card
    # true
  end
  
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
  
  def credit_card_attributes=(attributes)
    @credit_card = CreditCard.new(attributes)
  end

  private

  def generate_code
    self.code = MultiCommerce::VoucherGenerator.generate
  end
end