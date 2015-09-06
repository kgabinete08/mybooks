class QueueItemsController < ApplicationController
  before_filter :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    book = Book.find(params[:book_id])
    queue_book(book)
    redirect_to reading_queue_path
  end

  private

  def queue_book(book)
    QueueItem.create(book: book, user: current_user, position: new_queue_item_position) unless current_user.queued_book?(book)
  end

  def new_queue_item_position
    current_user.queue_items.count + 1
  end
end