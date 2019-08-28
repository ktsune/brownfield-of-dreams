# frozen_string_literal: true

require 'rails_helper'

feature 'User authenticates with oauth' do
  before :each do
    user = User.create!(email: 'user@gmail.com', first_name: 'User', last_name: 'McUserton', password: 'password', role: :default)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  scenario 'through github' do
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      data: {
        provider: 'github',

        uid: { id: '123545' },

        name: 'Aurie',
        html_url: 'www.github.com',
        login: 'aurie',

        info: { nickname: 'aurie' },

        credentials: { token: '12345' }
      }
    )

    visit '/dashboard'

    expect(current_path).to eq('/dashboard')

    click_on 'Connect to GitHub'

    expect(page).to have_content('Github')

    within('.followers') do
      within(first('.follower')) do
        expect(page).to have_css('.name')
      end
    end

    within('.repos') do
      within(first('.repo')) do
        expect(page).to have_css('.name')
      end
    end

    within('.following') do
      within(first('.follow')) do
        expect(page).to have_css('.name')
      end
    end
  end
end
