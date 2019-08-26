require 'rails_helper'

feature 'Github Repos' do
  scenario 'User can see 5 repos' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette("synopsis") do
      visit '/dashboard'
    end

    expect(current_path).to eq(dashboard_path)

    within('#repos') do
      expect(page).to have_css(".repo", count: 5)
      within(first(".repo")) do
        expect(page).to have_link("JoriPeterson/battleship")
      end
    end
  end

  scenario 'User can see bookmarks sectioned by tutorial type and ordered by position' do
    user = create(:user)
    video = create(:video)
    user_video = create(:user_video, user_id: user.id, video_id: video.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    expect(page).to have_content(video.title)
  end
end
