class Product < ActiveRecord::Base
  attr_accessible :name, :description, :price, :franchise
  belongs_to :franchise
  has_many :line_items
end