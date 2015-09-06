class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates_presence_of :password

  has_many :reviews
  has_many :queue_items

  has_secure_password validations: false

  def queued_book?(book)
    queue_items.map(&:book).include?(book)
  end
end