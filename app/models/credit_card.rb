class CreditCard
  include ActiveModel::Validations
  
  attr_accessor :card_holder_name, :number, :installments, :security_code, :expiration_date
  
  validates :card_holder_name, presence: true
  validates :number, presence: true
  validates :installments, presence: true

  validates :security_code, presence: true
  validates :security_code, length: { is: 3 }

  validates :expiration_date, presence: true
  validates :expiration_date, format: { with: /^\d{2}\/\d{4}$/ }

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def persisted?
    false
  end
end