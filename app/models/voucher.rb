# encoding: UTF-8
class Voucher < ActiveRecord::Base
  belongs_to :unity
  belongs_to :lead
  belongs_to :timetable
  has_many :line_items
  has_one :address
  has_many :products, through: :line_items
  # has_many :payments, class_name: Akatus::Payment
  has_one :franchise, through: :unity
  
  attr_accessible :used_at, :unity_id, :payment_method, :total, :timetable_id, :status, :credit_card, :credit_card_attributes, 
                  :lead_attributes, :address_attributes, :cpf, :line_item_ids, :transaction_key, :payment_url, :code
  
  before_validation :normalize_cpf
  before_create :generate_code
  
  attr_accessor :credit_card
  
  accepts_nested_attributes_for :address
  
  after_initialize :build_credit_card
  
  def build_credit_card
    self.credit_card = CreditCard.new
  end
  
  CREDIT_CARDS = ['cartao_visa', 'cartao_master', 'cartao_amex', 'cartao_elo', 'cartao_diners']
  
  STATUSES = ['Aguardando Pagamento', 'Em Análise', 'Aprovado', 'Cancelado']
  # validates :status, inclusion: {in: STATUSES}
  
  payment_method_is_credit_card = Proc.new { |v| v.payment_method? && v.payment_method != 'boleto' }
  validates :cpf, cpf: true, presence: true, on: :update, if: payment_method_is_credit_card
  
  # scope :paid, where(status: 'Aprovado')
  # scope :pending, where("vouchers.status != ?", 'Aprovado')
  
  paginates_per 10
  
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
  
  validate :validate_credit_card, if: payment_method_is_credit_card
  
  def validate_credit_card
    # errors.add(:credit_card, 'credit card validation errors') if credit_card? and not credit_card.valid? # TODO:
    credit_card.valid? # TODO:
  end
  
  def use
    update_attributes! used_at: Time.now
    siblings.each(&:invalidate)
    lead.enroll
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
  
  def payment_processed?
    !status.blank?
  end
  
  def credit_card?
    # payment_method? && payment_method != 'boleto'
    payment_method? && CREDIT_CARDS.include?(payment_method)
  end
  
  def payment_approved?
    status == 'Aprovado'
  end

  def invalidate
    update_attributes! status: 'Invalidado'
  end

  private
  
  def normalize_cpf
    self.cpf = self.cpf.gsub(/\D/, '') if cpf?
  end
  
  def siblings
    lead.vouchers - [self]
  end

  def generate_code
    self.code = MultiCommerce::VoucherGenerator.generate
  end
end