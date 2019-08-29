# frozen_string_literal: true

require 'rails_helper'

feature 'User authenticates with oauth' do
  before :each do
    user = User.create!(email: 'user@gmail.com', first_name: 'User', last_name: 'McUserton', password: 'password', role: :default)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  before :each do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({

        uid: { id: '123545' },

        info: { :nickname => 'aurie' },

        credentials: { token: ENV['GITHUB_TOKEN'] }
    })
    # OmniAuth.config.mock_auth[:github]
    # OmniAuth.config.add_mock(:github, github_mock)

    # request.env["devise.mapping"] = Devise.mappings[:user] # If using Devise
    # request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]

  end

  scenario 'through github' do
    VCR.use_cassette('auth') do
      visit '/dashboard'

      expect(current_path).to eq('/dashboard')

      click_on 'Connect to Github'

      expect(page).to have_content('Github')

      within('.followers') do
        within(first('.follower')) do
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
end
