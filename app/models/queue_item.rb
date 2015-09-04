class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  def book_title
    book.title
  end
end