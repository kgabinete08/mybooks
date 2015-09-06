require 'spec_helper'

describe BooksController do
  describe "GET show" do
    let(:book) { Fabricate(:book) }

    it_behaves_like "requires sign in" do
      let(:action) { get :show, id: book.id }
    end

    it "sets @book for authenticated users" do
      set_current_user
      get :show, id: book.id
      expect(assigns(:book)).to eq(book)
    end

    it "sets @reviews for authenticated users" do
      set_current_user
      review1 = Fabricate(:review, book: book)
      review2 = Fabricate(:review, book: book)
      get :show, id: book.id
      expect(assigns(:reviews)).to match_array([review1, review2])
    end
  end
end