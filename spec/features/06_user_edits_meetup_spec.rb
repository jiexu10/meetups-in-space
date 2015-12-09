# As a meetup creator
# I want to change my meetup's details
# So the meetup has up-to-date details

require "spec_helper"

feature "edit a meetup" do
  include Seeder

  scenario "user is not signed in" do
    seed_db

    visit "/meetups"
    click_link("coolthing")

    expect(current_path).to eq('/meetup/1')
    expect(page).to_not have_css('form#edit-button')
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
    expect(page).to_not have_css('form#edit-button')
    expect(page).to have_content("You can't edit this meetup!")
  end

  scenario "user edits the page" do
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
    click_button('Edit Meetup')

    expect(current_path).to eq('/meetups/edit/1')
    expect(page).to have_field('Name', with: 'coolthing')
    expect(page).to have_field('Location', with: 'somewhere')
    expect(page).to have_field('Description', with: 'fun')

    fill_in('Name', with: 'editedmeetup')
    fill_in('Location', with: 'editedlocation')
    fill_in('Description', with: 'editeddescription')
    click_button('Update Meetup')

    expect(current_path).to eq('/meetup/1')
    expect(page).to have_content("name: editedmeetup")
    expect(page).to have_content("description: editeddescription")
    expect(page).to have_content("location: editedlocation")
    expect(page).to have_content("creator: testusername")
  end

  scenario "user edits the page but leaves a blank" do
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
    click_button('Edit Meetup')

    expect(current_path).to eq('/meetups/edit/1')
    expect(page).to have_field('Name', with: 'coolthing')
    expect(page).to have_field('Location', with: 'somewhere')
    expect(page).to have_field('Description', with: 'fun')

    fill_in('Name', with: 'editedmeetup')
    fill_in('Location', with: '')
    fill_in('Description', with: 'editeddescription')
    click_button('Update Meetup')

    expect(current_path).to eq('/meetups/edit/1')
    expect(page).to have_field('Name', with: 'editedmeetup')
    expect(page).to have_field('Location', with: '')
    expect(page).to have_field('Description', with: 'editeddescription')

    fill_in('Location', with: 'neweditlocation')
    click_button('Update Meetup')

    expect(current_path).to eq('/meetup/1')
    expect(page).to have_content("name: editedmeetup")
    expect(page).to have_content("description: editeddescription")
    expect(page).to have_content("location: neweditlocation")
    expect(page).to have_content("creator: testusername")
  end
end
