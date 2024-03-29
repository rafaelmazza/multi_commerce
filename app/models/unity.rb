class Unity < ActiveRecord::Base
  include PgSearch
  # pg_search_scope :search_by_address, :against => :address
  pg_search_scope :search_by_address, :against => [:address_street, :address_number, :address_district, :address_zipcode, :address_city, :address_state]
  
  attr_accessible :code, :name, :phone, :phone_code, :email, :address, :status, :situation, :franchise_acronym, :latitude, :longitude, :user_ids, :franchise_id,
                  :address_street, :address_number, :address_district, :address_zipcode, :address_city, :address_state, :enrolled_leads_count
  
  STATUSES = {
    none: 0,
    updated: 1,
    outdated: 2,
    blocked: 3,
    active: 4,
    closed: 5
  }
  
  default_scope where(status: STATUSES[:active].to_s)
  
  has_and_belongs_to_many :users, uniq: true
  belongs_to :franchise
  has_many :leads
  has_many :vouchers
  
  geocoded_by :address
  
  paginates_per 3
  
  def self.ranking(limit=10)
    select = 'unities.*, count(leads.id) as enrolled_leads_count'
    group = 'unities.id'
    order = 'enrolled_leads_count DESC'
    joins = [:leads, :franchise]
    conditions = 'leads.enrolled_at IS NOT NULL'
    find(:all, select: select, group: group, order: order, joins: joins, conditions: conditions, limit: limit)
  end
  
  def self.nearby(lead, radius=9)
    unities = near(lead.location, radius)
    unities = search_by_address(lead.address_search) if unities.empty?
    unities
  end
  
  def address
    [address_street, address_number, address_district, address_city, address_state, 'Brasil'].compact.join(', ')
  end
end