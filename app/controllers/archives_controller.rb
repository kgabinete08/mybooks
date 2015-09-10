class ArchivesController < ApplicationController
  before_filter :require_user

  def index
    @archives = current_user.previously_read_books
  end

  def create

  end
end