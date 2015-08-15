class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates_presence_of :password

  has_secure_password validations: false
end