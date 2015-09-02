require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    let(:book) { Fabricate(:book) }

    context "with authenticated users" do
      let(:current_user) { Fabricate(:user) }
      before { set_current_user(current_user) }

      context "with valid input" do
        it "creates a review" do
          post :create, review: Fabricate.attributes_for(:review), book_id: book.id
          expect(Review.count).to eq(1)
        end

        it "creates the review associated with the book" do
          post :create, review: Fabricate.attributes_for(:review), book_id: book.id
          expect(Review.first.book).to eq(book)
        end

        it "creates the review associated with the current signed in user" do
          post :create, review: Fabricate.attributes_for(:review), book_id: book.id
          expect(Review.first.user).to eq(current_user)
        end

        it "redirects to the book show page" do
          post :create, review: Fabricate.attributes_for(:review), book_id: book.id
          expect(response).to redirect_to book
        end
      end
      context "with invalid input"
    end

    context "with unauthenticated users"
  end
end