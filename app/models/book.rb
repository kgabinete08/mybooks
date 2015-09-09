class Book < ActiveRecord::Base
  belongs_to :category

  has_many :reviews, -> { order("created_at DESC") }

  validates_presence_of :title

  def self.search_by_title(keyword)
    return [] if keyword.blank?
    where("title ILIKE ?", "%#{keyword.downcase}%").order("created_at DESC")
  end
end