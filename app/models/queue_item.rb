class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  delegate :category, to: :book
  delegate :title, to: :book, prefix: :book

  validates :position, numericality: { only_integer: true }

  def rating
    review.rating if review
  end

  def rating=(new_rating)
    if review
      review.update_column(:rating, new_rating)
    else
      review = Review.new(user: user, book: book, rating: new_rating)
      review.save!(validate: false)
    end
  end

  def category_name
    category.name
  end

  private

  def review
    @review ||= Review.find_by(user_id: user.id, book_id: book.id)
  end
end