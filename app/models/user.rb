class User < ActiveRecord::Base
  after_initialize :set_role_behavior
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:email, :domain]

  attr_accessible :email, :password, :password_confirmation, :remember_me, :role, :unity_ids, :franchise_ids
  
  has_and_belongs_to_many :unities
  has_and_belongs_to_many :franchises
    
  # restrict user to franchise domain
  def self.find_for_authentication(conditions={})
    where(["users.email = :value", { :value => conditions.delete(:email) }])
        .find(:first, :conditions => { :franchises => { :name => conditions.delete(:domain) } }, :joins => :franchises, :readonly => false)
  end
  
  def manager?
    role == 'manager'
  end

  private
  
  def set_role_behavior
    self.class.send :include, eval("Roles::#{role.camelize}")
  end
end
