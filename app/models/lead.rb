class Lead < ActiveRecord::Base
  attr_accessible :name, :email, :phone_code, :phone, :address_search, :latitude, :longitude, :unity_id, :prospected_at, 
                  :enrolled_at, :created_at, :updated_at, :campaign_id, :franchise_id, :voucher_ids
  
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
  # has_one :address
  belongs_to :campaign
  belongs_to :franchise
  
  # attr_accessor :credit_card
  attr_accessor :current_voucher
  
  geocoded_by :address_search
  
  # concerns
  # include Filterable
  
  paginates_per 10
  
  # CSV
  comma do
    name
    email
    phone_code
    phone
    prospected_at
    enrolled_at
    created_at { |created_at| created_at.strftime("%d/%m/%Y %H:%M") }
    updated_at
  end
  
  # accepts_nested_attributes_for :address
  
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
  
  def geolocated?
    latitude? and longitude?
  end
  
  def location
    return [latitude, longitude] if geolocated?
    address_search
  end
  
  def enroll
    update_attributes! enrolled_at: Time.now
  end
  
  private
  
  def generate_voucher
    voucher = self.vouchers.where(unity_id: unity.id, status: nil).find(:last)
    voucher = self.vouchers.create(unity_id: unity.id) unless voucher
    # voucher = self.vouchers.find_or_create_by_unity_id(unity_id: unity.id)
    voucher.build_address unless voucher.address
    voucher
  end
end