class Campaign < ActiveRecord::Base
  attr_accessible :name
  
  has_many :leads
end