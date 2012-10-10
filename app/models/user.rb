class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  
  has_and_belongs_to_many :unities
  
  def self.find_for_authentication(conditions={})
    p 'aqui'
    p conditions.inspect
    find(:first, :conditions => { :franchises => { :name => 'wizard' } }, :joins => :franchises)
  end
end
