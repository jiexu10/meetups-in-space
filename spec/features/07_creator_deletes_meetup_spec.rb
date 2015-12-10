# As a meetup creator
# I want to cancel my meetup
# So nobody comes to a meetup that is not taking place

require "spec_helper"

feature "edit a meetup" do

  let(:user) { FactoryGirl.create(:user) }
  let!(:meetup) { FactoryGirl.create(:meetup) }
  scenario "user is not signed in" do
    visit "/meetups"
    click_link(meetup.name)

    expect(current_path).to eq("/meetup/#{meetup.id}")
    expect(page).to_not have_css('form#delete-button')
    expect(page).to have_content("You can't edit this meetup!")
  end

  scenario "user is not the creator" do
    visit "/meetups"
    sign_in_as(user)
    click_link(meetup.name)

    expect(page).to have_content(meetup.name)
    expect(page).to have_content("description: #{meetup.description}")
    expect(page).to have_content("location: #{meetup.location}")
    expect(page).to have_content("creator: #{meetup.creator.username}")

    expect(current_path).to eq("/meetup/#{meetup.id}")
    expect(page).to_not have_css('form#delete-button')
    expect(page).to have_content("You can't edit this meetup!")
  end

  scenario "user deletes the meetup" do
    visit "/meetups"
    sign_in_as(meetup.creator)
    click_link(meetup.name)

    expect(page).to have_content(meetup.name)
    expect(page).to have_content("description: #{meetup.description}")
    expect(page).to have_content("location: #{meetup.location}")
    expect(page).to have_content("creator: #{meetup.creator.username}")

    expect(current_path).to eq("/meetup/#{meetup.id}")
    click_button('Delete Meetup')

    expect(current_path).to eq('/meetups')
    expect(page).to_not have_content(meetup.name)
    expect(page).to_not have_content("description: #{meetup.description}")
    expect(page).to_not have_content("location: #{meetup.location}")
    expect(page).to_not have_content("creator: #{meetup.creator.username}")
  end
end
