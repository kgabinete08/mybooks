class BooksController < ApplicationController
  before_filter :require_user

  def index
    @categories = Category.all
  end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews
  end

  def search
    @results = Book.search_by_title(params[:keyword])
  end
end