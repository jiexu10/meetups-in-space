# As a user
# I want to view the details of a meetup
# So that I can learn more about its purpose

require "spec_helper"

feature "user views meetup show page" do

  let!(:meetup) { FactoryGirl.create(:meetup) }
  scenario "visit the show page from the meetup list" do
    visit "/meetups"

    click_link(meetup.name)
    expect(page).to have_content(meetup.name)
    expect(page).to have_content(meetup.description)
    expect(page).to have_content(meetup.location)
    expect(page).to have_content(meetup.creator.username)
  end
end
