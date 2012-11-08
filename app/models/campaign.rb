class Campaign < ActiveRecord::Base
  attr_accessible :name, :lead_ids, :franchise_id
  
  has_many :leads
  belongs_to :franchise
end