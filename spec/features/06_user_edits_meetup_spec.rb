# As a meetup creator
# I want to change my meetup's details
# So the meetup has up-to-date details

require "spec_helper"

feature "edit a meetup" do

  let(:user) { FactoryGirl.create(:user) }
  let!(:meetup) { FactoryGirl.create(:meetup) }
  scenario "user is not signed in" do
    visit "/meetups"
    click_link(meetup.name)

    expect(current_path).to eq("/meetup/#{meetup.id}")
    expect(page).to_not have_css('form#edit-button')
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
    expect(page).to_not have_css('form#edit-button')
    expect(page).to have_content("You can't edit this meetup!")
  end

  scenario "user edits the page" do
    visit "/meetups"
    sign_in_as(meetup.creator)
    click_link(meetup.name)

    expect(page).to have_content(meetup.name)
    expect(page).to have_content("description: #{meetup.description}")
    expect(page).to have_content("location: #{meetup.location}")
    expect(page).to have_content("creator: #{meetup.creator.username}")

    expect(current_path).to eq("/meetup/#{meetup.id}")
    click_button('Edit Meetup')

    expect(current_path).to eq("/meetups/edit/#{meetup.id}")
    expect(page).to have_field('Name', with: meetup.name)
    expect(page).to have_field('Location', with: meetup.location)
    expect(page).to have_field('Description', with: meetup.description)

    fill_in('Name', with: 'editedmeetup')
    fill_in('Location', with: 'editedlocation')
    fill_in('Description', with: 'editeddescription')
    click_button('Update Meetup')

    expect(current_path).to eq("/meetup/#{meetup.id}")
    expect(page).to have_content("name: editedmeetup")
    expect(page).to have_content("description: editeddescription")
    expect(page).to have_content("location: editedlocation")
    expect(page).to have_content("creator: #{meetup.creator.username}")
  end

  scenario "user edits the page but leaves a blank" do
    visit "/meetups"
    sign_in_as(meetup.creator)
    click_link(meetup.name)

    expect(page).to have_content(meetup.name)
    expect(page).to have_content("description: #{meetup.description}")
    expect(page).to have_content("location: #{meetup.location}")
    expect(page).to have_content("creator: #{meetup.creator.username}")

    expect(current_path).to eq("/meetup/#{meetup.id}")
    click_button('Edit Meetup')

    expect(current_path).to eq("/meetups/edit/#{meetup.id}")
    expect(page).to have_field('Name', with: meetup.name)
    expect(page).to have_field('Location', with: meetup.location)
    expect(page).to have_field('Description', with: meetup.description)

    fill_in('Name', with: 'editedmeetup')
    fill_in('Location', with: '')
    fill_in('Description', with: 'editeddescription')
    click_button('Update Meetup')

    expect(current_path).to eq("/meetups/edit/#{meetup.id}")
    expect(page).to have_field('Name', with: 'editedmeetup')
    expect(page).to have_field('Location', with: '')
    expect(page).to have_field('Description', with: 'editeddescription')

    fill_in('Location', with: 'neweditlocation')
    click_button('Update Meetup')

    expect(current_path).to eq("/meetup/#{meetup.id}")
    expect(page).to have_content("name: editedmeetup")
    expect(page).to have_content("description: editeddescription")
    expect(page).to have_content("location: neweditlocation")
    expect(page).to have_content("creator: #{meetup.creator.username}")
  end
end
