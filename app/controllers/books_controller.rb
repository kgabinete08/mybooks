class BooksController < ApplicationController
  before_filter :require_user

  def index
    @categories = Category.all
  end
end