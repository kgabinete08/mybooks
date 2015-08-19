require 'spec_helper'

describe BooksController do
  describe "GET show" do
    it "sets @book for authenticated users" do
      set_current_user
      book = Fabricate(:book)
      get :show, id: book.id
      expect(assigns(:book)).to eq(book)
    end

    it "redirects unauthenticated users to the sign in page" do
      book = Fabricate(:book)
      get :show, id: book.id
      expect(response).to redirect_to sign_in_path
    end
  end
end