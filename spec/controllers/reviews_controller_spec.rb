require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    let(:book) { Fabricate(:book) }

    it_behaves_like "requires sign in" do
      let(:action) { post :create, review: Fabricate.attributes_for(:review), book_id: book.id }
    end

    context "with authenticated users" do
      let(:current_user) { Fabricate(:user) }
      before { set_current_user(current_user) }

      context "with valid input" do
        before do
          post :create, review: Fabricate.attributes_for(:review), book_id: book.id
        end

        it "creates a review" do
          expect(Review.count).to eq(1)
        end

        it "creates the review associated with the book" do
          expect(Review.first.book).to eq(book)
        end

        it "creates the review associated with the current signed in user" do
          expect(Review.first.user).to eq(current_user)
        end

        it "sets the flash message" do
          expect(flash).to be_present
        end

        it "redirects to the book show page" do
          expect(response).to redirect_to book
        end
      end

      context "with invalid input" do
        it "does not create a review" do
          post :create, review: { rating: 1 }, book_id: book.id
          expect(Review.count).to eq(0)
        end

        it "sets the flash message" do
          post :create, review: { rating: 1 }, book_id: book.id
          expect(flash).to be_present
        end

        it "renders the books/show template" do
          post :create, review: { rating: 1 }, book_id: book.id
          expect(response).to render_template 'books/show'
        end

        it "sets the @book variable" do
          post :create, review: { rating: 1 }, book_id: book.id
          expect(assigns(:book)).to eq(book)
        end

        it "sets the @reviews variable" do
          review = Fabricate(:review, book: book)
          post :create, review: { rating: 1 }, book_id: book.id
          expect(assigns(:reviews)).to match_array([review])
        end
      end
    end
  end
end