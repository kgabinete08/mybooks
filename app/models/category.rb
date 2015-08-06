class Category < ActiveRecord::Base
  has_many :books

  validates_presence_of :name
end