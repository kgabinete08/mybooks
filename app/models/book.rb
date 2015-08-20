class Book < ActiveRecord::Base
  belongs_to :category

  has_many :notes

  validates_presence_of :title
end