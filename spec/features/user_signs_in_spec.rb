require 'spec_helper'

feature 'User signs in' do
  scenario 'with valid email and password' do
    alice = Fabricate(:user)
    sign_in(alice)
    expect(page).to have_content("You have logged in successfully!")
  end
end