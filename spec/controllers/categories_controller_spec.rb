require 'spec_helper'

describe CategoriesController do
  describe "GET show" do
    let(:category) { Fabricate(:category) }

    it_behaves_like "requires sign in" do
      let(:action) { get :show, id: category.id }
    end

    it "sets @category for authenticated users" do
      set_current_user
      get :show, id: category.id
      expect(assigns(:category)).to eq(category)
    end
  end
end