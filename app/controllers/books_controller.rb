class BooksController < ApplicationController
  def index
    @categories = Category.all
  end
end