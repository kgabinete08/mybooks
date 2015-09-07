require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:book) }
  it { should delegate_method(:category).to(:book) }
  it { should delegate_method(:title).to(:book).with_prefix(:book) }
  it { should validate_numericality_of(:position).only_integer }

  describe "#rating" do
    it "returns the rating from the review when a review is present" do
      user = Fabricate(:user)
      book = Fabricate(:book)
      review = Fabricate(:review, user: user, book: book, rating: 3)
      queue_item = Fabricate(:queue_item, user: user, book: book)
      expect(queue_item.rating).to eq(3)
    end

    it "returns nil when there is no review present" do
      user = Fabricate(:user)
      book = Fabricate(:book)
      queue_item = Fabricate(:queue_item, user: user, book: book)
      expect(queue_item.rating).to be_nil
    end
  end

  describe "#category_name" do
    it "returns the category name of the associated book" do
      action = Fabricate(:category, name: 'Action')
      book = Fabricate(:book, category: action)
      queue_item = Fabricate(:queue_item, book: book)
      expect(queue_item.category_name).to eq('Action')
    end
  end
end