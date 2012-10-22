class Campaign < ActiveRecord::Base
  attr_accessible :name, :lead_ids
  
  has_many :leads
end