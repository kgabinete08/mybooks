require 'spec_helper'

feature 'User adds book to archives' do
  scenario 'user marks book as read' do
    fantasy       = Fabricate(:category)
    twilight      = Fabricate(:book, category: fantasy)
    eclipse       = Fabricate(:book, category: fantasy)

    sign_in

    visit home_path
    mark_book_as_read(twilight)

    visit book_path(twilight)
    expect_book_to_be_marked_as_read("Marked as read")

    visit archives_path
    expect_book_to_be_in_archives(twilight)
  end

  def mark_book_as_read(book)
    find("a[href='/books/#{book.id}']").click
    click_link "Mark as read"
  end

  def expect_book_to_be_marked_as_read(button_text)
    expect(page).to have_content(button_text)
  end

  def expect_book_to_be_in_archives(book)
    expect(page).to have_content(book.title)
  end
end