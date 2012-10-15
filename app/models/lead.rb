class Lead < ActiveRecord::Base  
  attr_accessible :name, :email, :phone_code, :phone, :address_search, :latitude, :longitude, :cpf, :address_attributes, :unity_id #, :credit_card_attributes, :credit_card
  
  validates :name, presence: true
  
  validates :email, presence: true
  # validates :email, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  
  validates :address_search, presence: true

  validates :phone_code, presence: true
  validates :phone_code, numericality: true
  validates :phone_code, length: { is: 2 }
  validates :phone, presence: true
  validates :phone, numericality: true
  
  # payment_method_is_credit_card = Proc.new { |l| l.current_voucher and l.current_voucher.payment_method != 'boleto' }
  # validates :cpf, presence: true, if: payment_method_is_credit_card
  
  sp_cellphone_check = Proc.new { |p| p.phone_code == '11' && p.phone =~ /^(5[2-9]|6[0-9]|7[01234569]|8[0-9]|9[0-9]).+/ }
  # validates :phone, length: { is: 9 }, :if     => sp_cellphone_check
  validates :phone, length: { is: 8 }, :unless => sp_cellphone_check
  validates :phone, length: { minimum: 8 }
  validates_ninth_digit :phone
  
  belongs_to :unity, counter_cache: true
  has_many :vouchers
  has_one :address
  
  # attr_accessor :credit_card
  attr_accessor :current_voucher
  
  geocoded_by :address_search
  
  accepts_nested_attributes_for :address
  
  # payment_method_is_credit_card2 = Proc.new { |l| unity && self.vouchers.find_or_create_by_unity_id(unity_id: unity.id).payment_method != 'boleto' }
  # before_validation :check_credit_card, if: payment_method_is_credit_card2
  # 
  # def check_credit_card
  #   credit_card.valid? if credit_card
  #   # true
  # end
  
  def subscribe(unity)
    self.unity = unity
    save!
    generate_voucher    
  end
  
  # def credit_card_attributes=(attributes)
  #   @credit_card = CreditCard.new(attributes)
  # end
  
  private
  
  def generate_voucher
    # @current_voucher ||= self.vouchers.find_or_create_by_unity_id(unity_id: unity.id)
    self.vouchers.find_or_create_by_unity_id(unity_id: unity.id)
  end
end