# As a user
# I want to create a meetup
# So that I can gather a group of people to do an activity

require "spec_helper"

feature "user creates new meetup" do

  let(:user) { FactoryGirl.create(:user) }
  let!(:meetup) { FactoryGirl.create(:meetup) }
  scenario "create a new meetup with the appropriate values" do
    visit "/meetups"
    sign_in_as(user)
    click_link("Add New Meetup")

    expect(current_path).to eq('/meetups/new')
    fill_in('Name', with: 'newmeetup')
    fill_in('Location', with: 'newlocation')
    fill_in('Description', with: 'newdescription')
    click_button('Add')

    expect(current_path).to eq("/meetup/#{meetup.id + 1}")
    expect(page).to have_content('newmeetup')
    expect(page).to have_content('newlocation')
    expect(page).to have_content('newdescription')
    expect(page).to have_content(user.username)
  end

  scenario "user is not signed in" do
    visit "/meetups"
    expect(page).to_not have_css('#new-meetup')
    expect(page).to have_content('Please sign in to add new meetups!')
  end

  scenario "fail to add new meetup when there are errors" do
    visit "/meetups"
    sign_in_as(user)
    click_link("Add New Meetup")

    expect(current_path).to eq('/meetups/new')
    fill_in('Name', with: '')
    fill_in('Location', with: 'blankwithlocation')
    fill_in('Description', with: 'blankwithdescription')
    click_button('Add')

    expect(current_path).to eq('/meetups/new')
    expect(page).to have_field('Name', with: '')
    expect(page).to have_field('Location', with: 'blankwithlocation')
    expect(page).to have_field('Description', with: 'blankwithdescription')
    expect(page).to_not have_content('newlocation')
    expect(page).to_not have_content('newdescription')
  end
end
