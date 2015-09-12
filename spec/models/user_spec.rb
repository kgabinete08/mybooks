require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:username) }
  it { should have_many(:reviews) }
  it { should have_many(:queue_items).order(:position) }
  it { should have_many(:archives).order("created_at DESC") }

  describe "#previously_read_books" do
    it "returns an empty array when there no books marked as previously read" do
      book = Fabricate(:book)
      user = Fabricate(:user)
      expect(user.previously_read_books.count).to eq(0)
    end

    it "return an array of one item when there is one item marked as read" do
      book = Fabricate(:book)
      user = Fabricate(:user)
      Fabricate(:archive, book: book, user: user)
      expect(user.previously_read_books.count).to eq(1)
    end

    it "returns an array of multiple items when there are several books marked as read" do
      book1 = Fabricate(:book)
      book2 = Fabricate(:book)
      book3 = Fabricate(:book)
      user = Fabricate(:user)
      Fabricate(:archive, book: book1, user: user)
      Fabricate(:archive, book: book2, user: user)
      Fabricate(:archive, book: book3, user: user)
      expect(user.previously_read_books.count).to eq(3)
    end

    it "returns the items in reverse chronological order by created_at" do
      book1 = Fabricate(:book)
      book2 = Fabricate(:book)
      user = Fabricate(:user)
      archive1 = Fabricate(:archive, book: book1, user: user, created_at: 1.day.ago)
      archive2 = Fabricate(:archive, book: book2, user: user)
      expect(user.previously_read_books).to eq([archive2, archive1])
    end
  end
end