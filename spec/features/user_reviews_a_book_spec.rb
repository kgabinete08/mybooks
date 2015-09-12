require 'spec_helper'

feature 'User reviews a book' do
  scenario 'user adds a rating and review to a book' do
    fantasy  = Fabricate(:category)
    twilight = Fabricate(:book, category: fantasy)
    review   = Fabricate(:review)

    sign_in

    visit home_path
    open_book_page(twilight)

    select_rating('1 Star')
    fill_in_review(review.content)
    submit_review

    expect_review_to_be_added
  end

  def open_book_page(book)
    find("a[href='/books/#{book.id}']").click
  end

  def select_rating(rating)
    select(rating , from: 'review_rating')
  end

  def fill_in_review(review)
    fill_in('Write Review', with: "review")
  end

  def submit_review
    find('.reviews').click_button "Submit"
  end

  def expect_review_to_be_added
    expect(page).to have_content("Your review has been added.")
  end
end