# frozen_string_literal: true

require 'rails_helper'

feature 'Github Repos' do
  scenario 'User can see 5 repos' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette('synopsis') do
      visit '/dashboard'
    end

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_css('.repo', count: 5)

    within(first('.repo')) do
      expect(page).to have_link('.name')
    end
  end
end

feature 'Bookmarks' do
  scenario 'User can see bookmarks sectioned by tutorial type and ordered by position' do
    user = create(:user)
    tutorial1 = create(:tutorial)
    tutorial2 = create(:tutorial)
    tutorial3 = create(:tutorial)
    create(:user_video, user_id: user.id, video_id: tutorial1.videos[1].id)
    create(:user_video, user_id: user.id, video_id: tutorial1.videos[2].id)

    create(:user_video, user_id: user.id, video_id: tutorial2.videos[1].id)
    create(:user_video, user_id: user.id, video_id: tutorial2.videos[2].id)

    create(:user_video, user_id: user.id, video_id: tutorial3.videos[1].id)
    create(:user_video, user_id: user.id, video_id: tutorial3.videos[2].id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(page).to have_content(tutorial1.title)
    expect(page).to have_content(tutorial2.title)
    expect(page).to have_content(tutorial3.title)

    tutorial1.videos.each do |video|
      expect(page).to have_content(video[1])
      expect(page).to have_content(video[2])
    end

    tutorial2.videos.each do |video|
      expect(page).to have_content(video[1])
      expect(page).to have_content(video[2])
    end

    tutorial3.videos.each do |video|
      expect(page).to have_content(video[1])
      expect(page).to have_content(video[2])
    end
  end
end

feature 'Invites' do
  scenario 'User sends an invite to someone with an email' do
    user = create(:user)
    handle = 'HandleBloke'
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    WebMock.disable_net_connect!
    stub_request(:get, "https://api.github.com/users/#{handle}")
      .to_return(status: 200, headers: {}, body: '{"email":"e@mail.com"}')

    visit dashboard_path

    fill_in 'handle', with: 'HandleBloke'
    click_on 'Send Invite'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Sent an invite to HandleBloke')
  end

  scenario 'User sends an invite to someone without an email' do
    user = create(:user)
    handle = 'HandleBloke'
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    WebMock.disable_net_connect!
    stub_request(:get, "https://api.github.com/users/#{handle}")
      .to_return(status: 200, headers: {}, body: '{"email":null}')

    visit dashboard_path

    fill_in 'handle', with: 'HandleBloke'
    click_on 'Send Invite'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('HandleBloke doesn\'t have an email associated with their account.')
  end
end

feature 'Friendships' do
  scenario 'User can add a friend if the person has a github account' do
    user = create(:user)
    handle = 'HandleBloke'
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    WebMock.disable_net_connect!
    stub_request(:get, "https://api.github.com/users/#{handle}")
      .to_return(status: 200, headers: {}, body: '{"handle":"HandleBloke"}')

    visit dashboard_path
    click_on 'Add Friend'

    expect(current_path).to eq(dashboard_path)
  end

  scenario 'User cannot add a friend if the person does not have a github account' do
    user = create(:user)
    handle = 'HandleBloke'
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    WebMock.disable_net_connect!
    stub_request(:get, "https://api.github.com/users/#{handle}")
      .to_return(status: 200, headers: {}, body: '{"handle":null}')

    visit dashboard_path

    expect(current_path).to eq(dashboard_path)
  end
end
