class Franchise < ActiveRecord::Base
  attr_accessible :name, :url, :acronym
  
  has_many :products
  has_many :unities
end