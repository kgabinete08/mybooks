class ArchivesController < ApplicationController
  before_filter :require_user

  def index
    @archives = current_user.previously_read_books
  end

  def create
    @book = Book.find(params[:book_id])
    Archive.create(book: @book, user: current_user) unless current_user.archived_book?(@book)
    redirect_to archives_path
  end
end