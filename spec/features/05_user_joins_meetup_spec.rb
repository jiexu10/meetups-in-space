# As a user
# I want to join a meetup
# So that I can partake in this meetup

require "spec_helper"

feature "join a meetup" do

  let!(:user) { FactoryGirl.create(:user) }
  let(:meetup) { FactoryGirl.create(:meetup) }
  let!(:memberships) { FactoryGirl.create_list(:membership, 4, meetup: meetup) }
  scenario "user joins the meetup" do
    visit "/meetups"
    sign_in_as(user)
    click_link(meetup.name)

    expect(current_path).to eq("/meetup/#{meetup.id}")
    click_button("Join Meetup")

    expect(current_path).to eq("/meetup/join/#{meetup.id}")
    within(".member-list") do
      memberships.each do |membership|
        expect(page).to have_content(membership.user.username)
        expect(page).to have_content(membership.user.avatar_url)
      end
      expect(page).to have_content(user.username)
      expect(page).to have_content(user.avatar_url)
    end
  end

  scenario "user is already a member" do
    visit "/meetups"
    sign_in_as(memberships.first.user)
    click_link(meetup.name)

    expect(current_path).to eq("/meetup/#{meetup.id}")
    expect(page).to_not have_css("#join-button")
    expect(page).to have_css("#leave-button")
  end
end
