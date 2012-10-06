class Product < ActiveRecord::Base
  belongs_to :franchise
  has_many :line_items
end