class Product < ActiveRecord::Base
  has_many :lines
  validates :name, :presence => true
  validates :description, :presence => true
  validates :price, :presence => true,:numericality => true
end
