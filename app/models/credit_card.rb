class CreditCard
  include ActiveModel::Validations
  
  attr_accessor :card_holder_name, :number, :installments, :cvv, :expiration_date
  
  validates :card_holder_name, presence: true
  validates :number, presence: true
  validates :installments, presence: true
  validates :cvv, presence: true
  validates :expiration_date, presence: true

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def persisted?
    false
  end
end