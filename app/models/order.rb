class Order < ActiveRecord::Base
  belongs_to :customer
  has_many :lines

end
