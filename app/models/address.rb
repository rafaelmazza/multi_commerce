class Address < ActiveRecord::Base
  attr_accessible :zipcode, :street, :complement, :number, :district, :city, :state, :country, :voucher_id
  
  validates :zipcode, presence: true
  validates :zipcode, format: /^\d{5}-?\d{3}$/
  
  validates :street, presence: true
  validates :number, presence: true
  validates :district, presence: true
  validates :city, presence: true
  validates :state, presence: true
end