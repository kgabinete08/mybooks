require 'spec_helper'

describe BooksController do
  describe "GET show" do
    let(:book) { Fabricate(:book) }

    it_behaves_like "requires sign in" do
      let(:action) { get :show, id: book.id }
    end

    before { set_current_user }

    it "sets @book for authenticated users" do
      get :show, id: book.id
      expect(assigns(:book)).to eq(book)
    end

    it "sets @reviews for authenticated users" do
      review1 = Fabricate(:review, book: book)
      review2 = Fabricate(:review, book: book)
      get :show, id: book.id
      expect(assigns(:reviews)).to match_array([review1, review2])
    end
  end

  describe "GET search" do
    it_behaves_like "requires sign in" do
      let(:action) { get :search, keyword: 'Hello' }
    end

    it "sets @results for authenticated user" do
      set_current_user
      outliers = Fabricate(:book, title: "Outliers")
      get :search, keyword: 'out'
      expect(assigns(:results)).to eq([outliers])
    end
  end
end