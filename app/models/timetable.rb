class Timetable < ActiveRecord::Base
  attr_accessible :title, :description
  
  has_many :vouchers
end