require 'spec_helper'

describe SessionsController do
  describe "POST create" do
    context "with valid credentials" do
      before do
        @alice = Fabricate(:user)
        post :create, email: @alice.email, password: @alice.password
      end

      it "puts the signed in user into the session" do
        expect(session[:user_id]).to eq(@alice.id)
      end

      it "sets the flash success message" do
        expect(flash[:success]).to be_present
      end

      it "redirects to the home page" do
        expect(response).to redirect_to home_path
      end
    end

    context "with invalid credentials" do
      before do
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password + 'gibberish'
      end

      it "does not put the user into the session" do
        expect(session[:user_id]).to be_nil
      end

      it "sets the flash danger message" do
        expect(flash[:danger]).to be_present
      end

      it "redirects to the sign in path" do
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe "GET destroy" do
    before do
      set_current_user
      get :destroy
    end

    it "clears the session" do
      expect(session[:user_id]).to be_nil
    end

    it "sets the flash success message" do
      expect(flash[:success]).to be_present
    end

    it "redirects to the sign in page" do
      expect(response).to redirect_to root_path
    end
  end
end