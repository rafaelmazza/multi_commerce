class Franchise < ActiveRecord::Base
  attr_accessible :name, :url, :acronym, :payment_enabled, :title, :campaign_ids
  
  has_many :products
  has_many :unities
  # has_many :leads, through: :unities
  has_many :leads
  has_many :vouchers, through: :unities
  has_many :campaigns
end