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
    it_behaves_like "requires sign in" do
      let(:action) { post :create }
    end

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

  describe "POST update_queue" do
    it_behaves_like "requires sign in" do
      let(:action) { post :update_queue, queue_items: [{id: 1, position: 2}, {id: 2, position: 1}] }
    end

    context "with valid input" do
      let(:bob) { Fabricate(:user) }
      let(:book) { Fabricate(:book) }
      let(:queue_item1) { Fabricate(:queue_item, user: bob, position: 1, book: book) }
      let(:queue_item2) { Fabricate(:queue_item, user: bob, position: 2, book: book) }

      before { set_current_user(bob) }

      it "redirect to the reading queue page" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(response).to redirect_to reading_queue_path
      end

      it "reorders the queue items" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(bob.queue_items).to eq([queue_item2, queue_item1])
      end

      it "normalizes the order of position numbers" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 3}]
        expect(bob.queue_items.map(&:position)).to eq([1, 2])
      end
    end

    context "with invalid input" do
      let(:bob) { Fabricate(:user) }
      let(:book) { Fabricate(:book) }
      let(:queue_item1) { Fabricate(:queue_item, user: bob, position: 1, book: book) }
      let(:queue_item2) { Fabricate(:queue_item, user: bob, position: 2, book: book) }

      before { set_current_user(bob) }

      it "redirects to the reading queue page" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2.5}, {id: queue_item2.id, position: 3}]
        expect(response).to redirect_to reading_queue_path
      end

      it "sets the flash error message" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2.5}, {id: queue_item2.id, position: 3}]
        expect(flash[:danger]).to be_present
      end

      it "does not reorder the queue items" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2.5}]
        expect(queue_item1.reload.position).to eq(1)
      end
    end

    context "with queue items that do not belong to the current user" do
      it "does not modify the queue items" do
        max = Fabricate(:user)
        bob = Fabricate(:user)
        book = Fabricate(:book)
        set_current_user(bob)
        queue_item1 = Fabricate(:queue_item, user: max, position: 1, book: book)
        queue_item2 = Fabricate(:queue_item, user: bob, position: 2, book: book)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(queue_item1.reload.position).to eq(1)
      end
    end
  end

  describe "DELETE destroy" do
    it_behaves_like "requires sign in" do
      let(:action) { delete :destroy, id: 1 }
    end

    it "redirects to the reading queue page" do
      set_current_user
      queue_item = Fabricate(:queue_item)
      delete :destroy, id: queue_item.id
      expect(response).to redirect_to reading_queue_path
    end

    it "deletes the queue item" do
      bob = Fabricate(:user)
      set_current_user(bob)
      queue_item = Fabricate(:queue_item, user: bob)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(0)
    end

    it "normalizes the remaining queue items" do
      bob = Fabricate(:user)
      set_current_user(bob)
      queue_item1 = Fabricate(:queue_item, user: bob, position: 1)
      queue_item2 = Fabricate(:queue_item, user: bob, position: 2)
      queue_item3 = Fabricate(:queue_item, user: bob, position: 3)
      delete :destroy, id: queue_item1.id
      expect(bob.queue_items.map(&:position)).to eq([1, 2])
    end

    it "it does not delete the queue item if it does not belong to current user's queue" do
      bob = Fabricate(:user)
      max = Fabricate(:user)
      set_current_user(bob)
      queue_item = Fabricate(:queue_item, user: max)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(1)
    end
  end
end