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

  feature 'Friendships' do
    scenario 'User can see friends' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      friend_1 = create(:user)
      friend_2 = create(:user)
      friend_3 = create(:user)

      Friendship.create!(user_id: user.id, friend_id: friend_1.id)
      Friendship.create!(user_id: user.id, friend_id: friend_2.id)
      Friendship.create!(user_id: user.id, friend_id: friend_3.id)

      visit '/dashboard'

      expect(page).to have_content(friend_1.first_name)
      expect(page).to have_content(friend_2.first_name)
      expect(page).to have_content(friend_3.first_name)
    end
  end
end
