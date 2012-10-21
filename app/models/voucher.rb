class Voucher < ActiveRecord::Base
  belongs_to :unity
  belongs_to :lead
  belongs_to :timetable
  has_many :line_items
  has_one :address
  # has_many :payments, class_name: Akatus::Payment
  
  attr_accessible :used_at, :unity_id, :payment_method, :total, :timetable_id, :status, :credit_card, :credit_card_attributes, 
                  :lead_attributes, :address_attributes, :cpf, :line_item_ids, :transaction_key, :payment_url
  
  before_create :generate_code
  
  attr_accessor :credit_card
  
  accepts_nested_attributes_for :address
  
  after_initialize :build_credit_card
  
  def build_credit_card
    self.credit_card = CreditCard.new
  end
  
  payment_method_is_credit_card = Proc.new { |v| v.payment_method? && v.payment_method != 'boleto' }
  validates :cpf, cpf: true, presence: true, on: :update, if: payment_method_is_credit_card
  
  # Aguardando Pagamento, Em Análise, Aprovado ou Cancelado.
  
  # scope :paid, where(status: 'Aprovado')
  # scope :pending, where("vouchers.status != ?", 'Aprovado')
  
  # CSV
  comma do
    lead :name
    code
    used_at
    unity_id
    payment_method
    total
    timetable title: 'Horario'
    status
    cpf
  end
  
  validate :validate_credit_card
  
  def validate_credit_card
    errors.add(:credit_card, 'credit card validation errors') if credit_card? and not credit_card.valid?
  end
  
  def use
    update_attributes! used_at: Time.now
  end
    
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
  
  def update_total!
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
  
  def credit_card?
    payment_method? && payment_method != 'boleto'
  end
end