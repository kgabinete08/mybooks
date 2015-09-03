require 'spec_helper'

describe BooksController do
  describe "GET show" do
    it "sets @book for authenticated users" do
      set_current_user
      book = Fabricate(:book)
      get :show, id: book.id
      expect(assigns(:book)).to eq(book)
    end

    it "sets @reviews for authenticated users" do
      set_current_user
      book = Fabricate(:book)
      review1 = Fabricate(:review, book: book)
      review2 = Fabricate(:review, book: book)
      get :show, id: book.id
      expect(assigns(:reviews)).to match_array([review1, review2])
    end

    it "redirects unauthenticated users to the sign in page" do
      book = Fabricate(:book)
      get :show, id: book.id
      expect(response).to redirect_to sign_in_path
    end
  end
end