require 'spec_helper'

feature 'User interacts with the queue' do
  scenario 'user adds and reorders books in the reading queue' do
    fantasy       = Fabricate(:category)
    twilight      = Fabricate(:book, category: fantasy)
    eclipse       = Fabricate(:book, category: fantasy)
    breaking_dawn = Fabricate(:book, category: fantasy)
    new_moon      = Fabricate(:book, category: fantasy)

    sign_in

    add_book_to_queue(twilight)
    expect_book_to_be_in_queue(twilight)

    visit book_path(twilight)
    expect_book_to_be_marked_as_in_queue("Currently in queue")

    add_book_to_queue(eclipse)
    add_book_to_queue(breaking_dawn)
    add_book_to_queue(new_moon)

    set_book_position(twilight, 3)
    set_book_position(new_moon, 2)
    set_book_position(breaking_dawn, 4)

    update_queue

    expect_book_position(eclipse, 1)
    expect_book_position(new_moon, 2)
    expect_book_position(twilight, 3)
    expect_book_position(breaking_dawn, 4)
  end

  def add_book_to_queue(book)
    visit home_path
    find("a[href='/books/#{book.id}']").click
    click_link "+ Add to Queue"
  end

  def expect_book_to_be_in_queue(book)
    expect(page).to have_content(book.title)
  end

  def expect_book_to_be_marked_as_in_queue(button_text)
    expect(page).to have_content(button_text)
  end

  def set_book_position(book, position)
    within(:xpath, "//tr[contains(.,'#{book.title}')]") do
      fill_in "queue_items[][position]", with: position
    end
  end

  def update_queue
    click_button "Update Queue"
  end

  def expect_book_position(book, position)
    expect(find(:xpath, "//tr[contains(.,'#{book.title}')]//input[@type='text']").value).to eq(position.to_s)
  end
end