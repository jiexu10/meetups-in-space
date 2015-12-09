# As a user
# I want to join a meetup
# So that I can partake in this meetup

require "spec_helper"

feature "join a meetup" do
  include Seeder

  scenario "user joins and leaves the page" do
    seed_db
    test_user = User.find(4)

    visit "/meetups"
    sign_in_as(test_user)
    click_link("coolthing")

    expect(current_path).to eq('/meetup/1')
    click_button("Join Meetup")

    expect(current_path).to eq('/meetup/join/1')
    expect(page).to have_selector("ul.member-list li", text: "testusername")
    expect(page).to have_selector("ul.member-list li", text: "testav_url")
    expect(page).to have_selector("ul.member-list li", text: "testusername2")
    expect(page).to have_selector("ul.member-list li", text: "testav_url2")
    expect(page).to have_selector("ul.member-list li", text: "testusername3")
    expect(page).to have_selector("ul.member-list li", text: "testav_url3")
    expect(page).to have_selector("ul.member-list li", text: "thisguycreates")
    expect(page).to have_selector("ul.member-list li", text: "creator_url")

    click_button("Leave Meetup")
    expect(page).to have_selector("ul.member-list li", text: "testusername")
    expect(page).to have_selector("ul.member-list li", text: "testav_url")
    expect(page).to have_selector("ul.member-list li", text: "testusername2")
    expect(page).to have_selector("ul.member-list li", text: "testav_url2")
    expect(page).to have_selector("ul.member-list li", text: "testusername3")
    expect(page).to have_selector("ul.member-list li", text: "testav_url3")
  end
end
