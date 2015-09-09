require 'spec_helper'

describe Category do
  it { should validate_presence_of(:name) }

  describe "#recent_books" do
    let(:action) { Fabricate(:category, name: "Action") }

    it "returns an empty array if there are no items in a category" do
      expect(action.recent_books).to eq([])
    end

    it "returns the books in reverse chronological order by created_at" do
      outliers = Fabricate(:book, category: action, created_at: 1.day.ago)
      harry_potter = Fabricate(:book, category: action)
      expect(action.recent_books).to eq([harry_potter, outliers])
    end

    it "returns all books if there are less than 5 items in a category" do
      3.times { Fabricate(:book, category: action) }
      expect(action.recent_books.count).to eq(3)
    end

    it "returns 5 books if there more than 5 items in a category" do
      6.times { Fabricate(:book, category: action) }
      expect(action.recent_books.count).to eq(5)
    end

    it "returns the 5 most recent books" do
      5.times { Fabricate(:book, category: action) }
      book = Fabricate(:book, category: action, created_at: 1.day.ago)
      expect(action.recent_books).not_to include(book)
    end
  end
end