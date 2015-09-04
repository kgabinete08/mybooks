require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:book) }

  describe "#book_title" do
    it "returns the title of the associated book" do
      book = Fabricate(:book, title: 'Outliers')
      queue_item = Fabricate(:queue_item, book: book)
      expect(queue_item.book_title).to eq('Outliers')
    end
  end
end