# As a meetup creator
# I want to cancel my meetup
# So nobody comes to a meetup that is not taking place

require "spec_helper"

feature "edit a meetup" do
  include Seeder

  scenario "user is not signed in" do
    seed_db

    visit "/meetups"
    click_link("coolthing")

    expect(current_path).to eq('/meetup/1')
    expect(page).to_not have_css('form#delete-button')
    expect(page).to have_content("You can't edit this meetup!")
  end

  scenario "user is not the creator" do
    seed_db
    test_user = User.find(4)

    visit "/meetups"
    sign_in_as(test_user)
    click_link("coolthing")

    expect(page).to have_content("coolthing")
    expect(page).to have_content("description: fun")
    expect(page).to have_content("location: somewhere")
    expect(page).to have_content("creator: testusername")

    expect(current_path).to eq('/meetup/1')
    expect(page).to_not have_css('form#delete-button')
    expect(page).to have_content("You can't edit this meetup!")
  end

  scenario "user deletes the meetup" do
    seed_db
    test_user = User.find(1)

    visit "/meetups"
    sign_in_as(test_user)
    click_link("coolthing")

    expect(page).to have_content("coolthing")
    expect(page).to have_content("description: fun")
    expect(page).to have_content("location: somewhere")
    expect(page).to have_content("creator: testusername")

    expect(current_path).to eq('/meetup/1')
    click_button('Delete Meetup')

    expect(current_path).to eq('/meetups')
    expect(page).to_not have_content("coolthing")
    expect(page).to_not have_content("description: fun")
    expect(page).to_not have_content("location: somewhere")
    expect(page).to_not have_content("creator: testusername")

    expect(page).to have_selector("ul.meetup-list li:nth-child(1)", text: "otherthing")
    expect(page).to have_selector("ul.meetup-list li:nth-child(2)", text: "test3")
    expect(page).to have_selector("ul.meetup-list li:nth-child(3)", text: "test4")
    expect(page).to have_selector("ul.meetup-list li:nth-child(4)", text: "test5")
  end
end
