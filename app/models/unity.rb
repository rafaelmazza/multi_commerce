class Unity < ActiveRecord::Base
  attr_accessible :code, :name, :phone, :email, :address, :status, :situation, :franchise_acronym, :latitude, :longitude
  
  has_and_belongs_to_many :users
  belongs_to :franchise
  
  geocoded_by :address
end