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
end

feature 'Bookmarks' do
  scenario 'User can see bookmarks sectioned by tutorial type and ordered by position' do
    user = create(:user)
    tutorial_1 = create(:tutorial)
    tutorial_2 = create(:tutorial)
    tutorial_3 = create(:tutorial)
    create(:user_video, user_id: user.id, video_id: tutorial_1.videos[1].id)
    create(:user_video, user_id: user.id, video_id: tutorial_1.videos[2].id)

    create(:user_video, user_id: user.id, video_id: tutorial_2.videos[1].id)
    create(:user_video, user_id: user.id, video_id: tutorial_2.videos[2].id)

    create(:user_video, user_id: user.id, video_id: tutorial_3.videos[1].id)
    create(:user_video, user_id: user.id, video_id: tutorial_3.videos[2].id)


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(page).to have_content(tutorial_1.title)
    expect(page).to have_content(tutorial_2.title)
    expect(page).to have_content(tutorial_3.title)

    tutorial_1.videos.each do |video|
      expect(page).to have_content(video[1])
      expect(page).to have_content(video[2])
    end

    tutorial_2.videos.each do |video|
      expect(page).to have_content(video[1])
      expect(page).to have_content(video[2])
    end

    tutorial_3.videos.each do |video|
      expect(page).to have_content(video[1])
      expect(page).to have_content(video[2])
    end
  end
end
