class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates_presence_of :password

  has_many :reviews
  has_many :queue_items, -> { order(:position) }
  has_many :archives, -> { order("created_at DESC")}

  has_secure_password validations: false

  def queued_book?(book)
    queue_items.map(&:book).include?(book)
  end

  def queue_item_in_queue?(queue_item)
    queue_items.include?(queue_item)
  end

  def normalize_queue_item_positions
    queue_items.each_with_index do |queue_item, idx|
      queue_item.update!(position: idx + 1)
    end
  end

  def previously_read_books
    archives
  end
end