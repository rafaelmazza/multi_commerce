class Unity < ActiveRecord::Base
  attr_accessible :code, :name, :phone, :email, :address, :status, :situation, :franchise_acronym
end