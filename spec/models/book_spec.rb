require 'spec_helper'

describe Book do
  it { should validate_presence_of(:title) }
  it { should belong_to(:category) }
  it { should have_many(:reviews).order("created_at DESC") }
  it { should have_many(:archives) }

  describe ".search_by_title" do
    it "returns an empty array when there is no match" do
      outliers = Fabricate(:book, title: "Outliers")
      dragon = Fabricate(:book, title: "Girl with a Dragon Tattoo")
      expect(Book.search_by_title("Turtle")).to eq([])
    end

    it "returns an array of one item for an exact match" do
      outliers = Fabricate(:book, title: "Outliers")
      dragon = Fabricate(:book, title: "Girl with a Dragon Tattoo")
      expect(Book.search_by_title("Outliers")).to eq([outliers])
    end

    it "returns an array of one item for a partial match" do
      outliers = Fabricate(:book, title: "Outliers")
      dragon = Fabricate(:book, title: "Girl with a Dragon Tattoo")
      expect(Book.search_by_title("Out")).to eq([outliers])
    end

    it "returns an array of multiple items ordered by created at when there are several matches" do
      outliers = Fabricate(:book, title: "Outliers")
      out_of_sight = Fabricate(:book, title: "Out of Sight", created_at: 1.day.ago)
      expect(Book.search_by_title("Out")).to eq([outliers, out_of_sight])
    end

    it "returns an empty array when search parameter is an empty string" do
      outliers = Fabricate(:book, title: "Outliers")
      dragon = Fabricate(:book, title: "Girl with a Dragon Tattoo")
      expect(Book.search_by_title("")).to eq([])
    end

    it "it returns an array of non case sensitve matches" do
      outliers = Fabricate(:book, title: "Outliers")
      dragon = Fabricate(:book, title: "Girl with a Dragon Tattoo")
      expect(Book.search_by_title("out")).to eq([outliers])
    end
  end
end