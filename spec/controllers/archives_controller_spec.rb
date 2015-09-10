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

    end

    it "creates an archive item"
    it "creates an archive item associated with the book"
    it "creates an archive item associated with the current signed in user"
    it "add the archive item to the front of the list"
    it "does not archive the item if it has already been marked as read previously"
  end
end