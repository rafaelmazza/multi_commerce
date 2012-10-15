class CreditCard
  include ActiveModel::Validations
  
  attr_accessor :card_holder_name, :number, :installments, :cvv, :expiration_date, :cpf
  
  validates :card_holder_name, presence: true
  validates :number, presence: true
  validates :installments, presence: true
  validates :cvv, presence: true
  validates :expiration_date, presence: true
  validates :cpf, presence: true
  
  def initialize(attributes={})
    self.card_holder_name = attributes[:card_holder_name]
    self.number = attributes[:number]
    self.cvv = attributes[:cvv]
    self.expiration_date = attributes[:expiration_date]
    self.installments = 1
    self.cpf = attributes[:cpf]
  end
  
  def persisted?
    false
  end
end