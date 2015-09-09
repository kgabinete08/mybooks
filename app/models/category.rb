class Category < ActiveRecord::Base
  has_many :books, -> { order("created_at DESC") }

  validates_presence_of :name

  def recent_books
    books.first(5)
  end
end