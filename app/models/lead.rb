class Lead < ActiveRecord::Base
  attr_accessible :name, :email, :phone_code, :phone, :address_search, :latitude, :longitude
  
  validates :name, presence: true
  
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  
  validates :address_search, presence: true

  validates :phone_code, presence: true
  validates :phone_code, numericality: true
  validates :phone, presence: true
  validates :phone, numericality: true
  
  belongs_to :unity, counter_cache: true
  has_many :vouchers
  has_one :address
  
  attr_accessor :credit_card
  
  geocoded_by :address_search
  
  def subscribe(unity)
    self.unity = unity
    save!
    generate_voucher    
  end
  
  private
  
  def generate_voucher
    self.vouchers.create(unity_id: unity.id)
  end
end