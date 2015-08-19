class BooksController < ApplicationController
  before_filter :require_user

  def index
    @categories = Category.all
  end

  def show
    @book = Book.find(params[:id])
  end
end