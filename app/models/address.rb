class Address < ActiveRecord::Base
  attr_accessible :zipcode, :street, :complement, :number, :district, :city, :state
  
  # validates :zipcode, presence: true
  # validates :street, presence: true
  # validates :complement, presence: true
  # validates :number, presence: true
  # validates :district, presence: true
  # validates :city, presence: true
  # validates :state, presence: true
end