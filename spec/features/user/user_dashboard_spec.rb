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

    within('#repos') do
      expect(page).to have_css('.repo', count: 5)
      within(first('.repo')) do
        expect(page).to have_link('JoriPeterson/battleship')
      end
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
