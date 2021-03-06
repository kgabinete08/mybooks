class QueueItemsController < ApplicationController
  before_action :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    book = Book.find(params[:book_id])
    queue_book(book)
    redirect_to reading_queue_path
  end

  def update_queue
    begin
      update_queue_items
      current_user.normalize_queue_item_positions
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = "Invalid position number."
    end
    redirect_to reading_queue_path
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy if current_user.queue_item_in_queue?(queue_item)
    current_user.normalize_queue_item_positions
    redirect_to reading_queue_path
  end

  private

  def queue_book(book)
    QueueItem.create(book: book, user: current_user, position: new_queue_item_position) unless current_user.queued_book?(book)
  end

  def new_queue_item_position
    current_user.queue_items.count + 1
  end

  def update_queue_items
    ActiveRecord::Base.transaction do
      params[:queue_items].each do |queue_item_data|
        queue_item = QueueItem.find(queue_item_data["id"])
        queue_item.update!(position: queue_item_data["position"], rating: queue_item_data["rating"]) if queue_item.user == current_user
      end
    end
  end
end