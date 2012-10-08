class Address < ActiveRecord::Base
  attr_accessible :zipcode, :street, :complement, :number, :district, :city, :state
end