class BooksController < ApplicationController
  before_filter :require_user

  def index
    @categories = Category.all
  end

  def show
    @book = Book.find(params[:id])
    @note = current_user.notes.find_by(book_id: @book.id)
  end
end