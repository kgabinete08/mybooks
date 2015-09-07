class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  delegate :category, to: :book
  delegate :title, to: :book, prefix: :book

  validates :position, numericality: { only_integer: true }

  def rating
    review = Review.find_by(user_id: user.id, book_id: book.id)
    review.rating if review
  end

  def category_name
    category.name
  end
end