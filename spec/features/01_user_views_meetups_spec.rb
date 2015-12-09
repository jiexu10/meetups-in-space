# As a user
# I want to view a list of all available meetups
# So that I can get together with people with similar interests

require "spec_helper"

feature "user views meetup list" do
  scenario "sees meetups in alphabetical order" do
    FactoryGirl.create_list(:meetup, 5)
    
    visit "/meetups"
    expect(page).to have_selector("ul.meetup-list li:nth-child(1)", text: "coolthing1")
    expect(page).to have_selector("ul.meetup-list li:nth-child(2)", text: "coolthing2")
    expect(page).to have_selector("ul.meetup-list li:nth-child(3)", text: "coolthing3")
    expect(page).to have_selector("ul.meetup-list li:nth-child(4)", text: "coolthing4")
    expect(page).to have_selector("ul.meetup-list li:nth-child(5)", text: "coolthing5")
  end
end
