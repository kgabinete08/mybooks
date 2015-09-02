class Book < ActiveRecord::Base
  belongs_to :category

  has_many :reviews

  validates_presence_of :title
end