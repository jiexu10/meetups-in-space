# As a meetup member
# I want to leave a meetup
# So that I'm no longer listed as a member of the meetup

require "spec_helper"

feature "leave a meetup" do

  let(:user) { FactoryGirl.create(:user) }
  let(:meetup) { FactoryGirl.create(:meetup) }
  let!(:memberships) { FactoryGirl.create_list(:membership, 4, meetup: meetup) }
  scenario "user leaves the meetup" do
    page_memberships = memberships
    visit "/meetups"
    sign_in_as(page_memberships.last.user)
    click_link(meetup.name)
    within(".member-list") do
      page_memberships.each do |membership|
        expect(page).to have_content(membership.user.username)
        expect(page).to have_content(membership.user.avatar_url)
      end
    end

    click_button("Leave Meetup")
    expect(current_path).to eq("/meetup/leave/#{meetup.id}")
    within(".member-list") do
      last_user = page_memberships.last.user
      page_memberships.pop
      page_memberships.each do |membership|
        expect(page).to have_content(membership.user.username)
        expect(page).to have_content(membership.user.avatar_url)
      end
      expect(page).to_not have_content(last_user.username)
      expect(page).to_not have_content(last_user.avatar_url)
    end
  end

  scenario "user is not a member of group" do
    visit "/meetups"
    sign_in_as(user)
    click_link(meetup.name)

    expect(current_path).to eq("/meetup/#{meetup.id}")
    expect(page).to have_css("#join-button")
    expect(page).to_not have_css("#leave-button")
  end
end
