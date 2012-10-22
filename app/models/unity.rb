class Unity < ActiveRecord::Base
  attr_accessible :code, :name, :phone, :email, :address, :status, :situation, :franchise_acronym, :latitude, :longitude, :user_ids, :franchise_id
  
  has_and_belongs_to_many :users
  belongs_to :franchise
  has_many :leads
  has_many :vouchers
  
  geocoded_by :address
  
  paginates_per 3
  
  def self.ranking(franchise, limit=10)
    # find(:all, select: "unities.*, count(leads.id) as enrolled_leads_count", group: "unities.id", order: "enrolled_leads_count DESC", joins: :leads, conditions: ['leads.enrolled_at IS NOT NULL', "franchise_id = #{franchise_id}"])
    select = "unities.*, count(leads.id) as enrolled_leads_count"
    group = "unities.id"
    order = "enrolled_leads_count DESC"
    joins = [:leads, :franchise]
    conditions = "leads.enrolled_at IS NOT NULL AND unities.franchise_id = #{franchise.id}"
    find(:all, select: select, group: group, order: order, joins: joins, conditions: conditions, limit: limit)
  end
end