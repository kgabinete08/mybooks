require 'spec_helper'

describe ArchivesController do
  describe "GET index" do
    it_behaves_like "requires sign in" do
      let(:action) { get :index }
    end

    it "sets @archives for authenticated users" do
      alice = Fabricate(:user)
      set_current_user(alice)
      book = Fabricate(:book)
      archive = Fabricate(:archive, book: book, user: alice)
      get :index
      expect(assigns(:archives)).to match_array([archive])
    end
  end

  describe "POST create" do
    it_behaves_like "requires sign in" do
      let(:action) { get :index }
    end

    it "redirects to the archives page" do
      set_current_user
      book = Fabricate(:book)
      Fabricate(:archive, book: book)
      post :create, book_id: book.id
      expect(response).to redirect_to archives_path
    end

    it "creates an archive item" do
      set_current_user
      book = Fabricate(:book)
      post :create, book_id: book.id
      expect(Archive.count).to eq(1)
    end

    it "creates an archive item associated with the book" do
      set_current_user
      book = Fabricate(:book)
      post :create, book_id: book.id
      expect(Archive.first.book).to eq(book)
    end

    it "creates an archive item associated with the current signed in user" do
      alice = Fabricate(:user)
      set_current_user(alice)
      book = Fabricate(:book)
      post :create, book_id: book.id
      expect(Archive.first.user).to eq(alice)
    end

    it "add the created archive item to the front of the list" do
      alice = Fabricate(:user)
      set_current_user(alice)
      book1 = Fabricate(:book)
      book2 = Fabricate(:book)
      archive = Archive.create(book: book1, user: alice)
      post :create, book_id: book2.id
      expect(alice.archives.last).to eq(archive)
    end

    it "does not archive the item if it has already been marked as read previously" do
      alice = Fabricate(:user)
      set_current_user(alice)
      book = Fabricate(:book)
      Archive.create(book: book, user: alice)
      post :create, book_id: book.id
      expect(alice.archives.count).to eq(1)
    end
  end
end