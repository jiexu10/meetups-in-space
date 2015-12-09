# As a user
# I want to see who has already joined a meetup
# So that I can see if any of my friends have joined

require "spec_helper"

feature "user views meetup details and sees user list" do

  let(:user) { FactoryGirl.create(:user) }
  let(:meetup) { FactoryGirl.create(:meetup) }
  let!(:memberships) { FactoryGirl.create_list(:membership, 4, meetup: meetup) }
  scenario "user sees meetup through main page" do
    visit "/meetups"
    sign_in_as(user)
    click_link(meetup.name)

    expect(current_path).to eq("/meetup/#{meetup.id}")

    within ".member-list" do
    memberships.each do |membership|
        expect(page).to have_content(membership.user.username)
    end
      expect(page).to_not have_content(user.username)
    end
  end
end
