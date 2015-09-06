require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    it_behaves_like "requires sign in" do
      let(:action) { get :index }
    end

    it "sets @queue_items for the logged in user" do
      bob = Fabricate(:user)
      set_current_user(bob)
      queue_item1 = Fabricate(:queue_item, user: bob)
      queue_item2 = Fabricate(:queue_item, user: bob)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end
  end

  describe "POST create" do
    it "redirects to reading queue page" do
      set_current_user
      book = Fabricate(:book)
      post :create, book_id: book.id
      expect(response).to redirect_to reading_queue_path
    end

    it "creates a queue item" do
      set_current_user
      book = Fabricate(:book)
      post :create, book_id: book.id
      expect(QueueItem.count).to eq(1)
    end

    it "creates the queue item associated with the book" do
      set_current_user
      book = Fabricate(:book)
      post :create, book_id: book.id
      expect(QueueItem.first.book).to eq(book)
    end

    it "creates the queue item associated with the logged in user" do
      bob = Fabricate(:user)
      set_current_user(bob)
      book = Fabricate(:book)
      post :create, book_id: book.id
      expect(QueueItem.first.user).to eq(bob)
    end

    it "puts the book as the last item in the queue" do
      bob = Fabricate(:user)
      set_current_user(bob)
      book1 = Fabricate(:book)
      book2 = Fabricate(:book)
      Fabricate(:queue_item, book: book1, user: bob)
      post :create, book_id: book2.id
      book2_queue_item = QueueItem.find_by(book_id: book2.id, user_id: bob.id)
      expect(book2_queue_item.position).to eq(2)
    end

    it "does not add the book to the queue if it is already in the queue" do
      bob = Fabricate(:user)
      set_current_user(bob)
      book = Fabricate(:book)
      Fabricate(:queue_item, book: book, user: bob)
      post :create, book_id: book.id
      expect(bob.queue_items.count).to eq(1)
    end
  end
end