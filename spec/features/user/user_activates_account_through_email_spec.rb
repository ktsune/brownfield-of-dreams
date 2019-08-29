# frozen_string_literal: true

require 'rails_helper'

feature 'User Email' do
  scenario 'user can activate their account through email' do
    visit '/'
    click_on 'Register'

    expect(current_path).to eq('/register')

    fill_in "user[first_name]", with: 'Aurie'
    fill_in "user[last_name]", with: 'Auriest'
    fill_in "user[email]", with: 'auriest@aurie.com'
    fill_in "user[password]", with: 'password'
    fill_in "user[password_confirmation]", with: 'password'
    click_on 'Create Account'

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("Aurie's Dashboard")
  end

  scenario 'user can visit url explicitly' do
    user = create(:user, uuid: '12345')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/activate?uuid=#{user.uuid}"

    expect(current_path).to eq('/dashboard')
    expect(user.reload.activated).to eq(true)
  end
end
