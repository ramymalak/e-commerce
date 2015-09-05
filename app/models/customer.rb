class Customer < ActiveRecord::Base
  has_secure_password
  has_many :orders
  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
  validates :firstname, :presence => true
  validates :lastname, :presence => true
  validates :email, :presence => true,
            :format => EMAIL_REGEX,
            :uniqueness => true
end
