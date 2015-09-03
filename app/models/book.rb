class Book < ActiveRecord::Base
  belongs_to :category

  has_many :reviews, -> { order("created_at DESC") }

  validates_presence_of :title
end