require 'rails_helper'

feature 'User Sees Friends' do
  scenario 'lookit dem friendos' do
    user1 = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
    user2 = create(:user)
    user3 = create(:user)
    Friendship.create!(user_id: user1.id, friend_id: user2.id)
    Friendship.create!(user_id: user1.id, friend_id: user3.id)

    visit dashboard_path

    within('#friends') do
      expect(page).to have_content(user2.first_name)
      expect(page).to have_content(user3.first_name)
    end
  end

  scenario 'user make frend' do
    user1 = create(:user, token: '12345')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
    friend1 = create(:user, uid: '111')
    friend3 = create(:user, uid: '333')
    friend4 = create(:user, uid: '444')

    response_body = [
      {'id' => '111', 'login' => 'follower1', 'html_url' => '#'},
      {'id' => '222', 'login' => 'follower2', 'html_url' => '#'},
      {'id' => '333', 'login' => 'follower3', 'html_url' => '#'},
      {'id' => '444', 'login' => 'follower4', 'html_url' => '#'},
      {'id' => '555', 'login' => 'follower5', 'html_url' => '#'}
    ].to_json

    fake_repos = [
      {'html_url' => '#', 'full_path' => 'yeet'}
    ].to_json

    WebMock.disable_net_connect!
    stub_request(:get, "https://api.github.com/user/repos")
      .to_return(status: 200, headers: {}, body: fake_repos)
    stub_request(:get, "https://api.github.com/user/followers")
      .to_return(status: 200, headers: {}, body: response_body)
    stub_request(:get, "https://api.github.com/user/following")
      .to_return(status: 200, headers: {}, body: response_body)

    visit dashboard_path

    within('#followers') do
      within('#follower-111') do
        expect(page).to have_content('Add Friend')
      end
      within('#follower-222') do
        expect(page).to_not have_content('Add Friend')
      end
      within('#follower-333') do
        expect(page).to have_content('Add Friend')
      end
      within('#follower-444') do
        expect(page).to have_content('Add Friend')
      end
      within('#follower-555') do
        expect(page).to_not have_content('Add Friend')
      end
    end
  end
end
