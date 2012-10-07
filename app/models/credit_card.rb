class CreditCard
  attr_accessor :card_holder_name, :number, :installments, :cvv, :expiration_date
  
  def initialize(attributes={})
    self.card_holder_name = attributes[:card_holder_name]
    self.number = attributes[:number]
    self.cvv = attributes[:cvv]
    self.expiration_date = attributes[:expiration_date]
    self.installments = 1
  end
end