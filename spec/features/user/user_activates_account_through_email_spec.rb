require 'rails_helper'

feature 'User Email' do
  scenario 'user can activate their account through email' do

    visit '/'
    click_on 'Register'

    expect(current_path).to eq('/register')

    fill_in :first_name, with: 'Aurie'
    fill_in :last_name, with: 'Auriest'
    fill_in :email, with: 'auriest@aurie.com'
    fill_in :password, with: 'password'
    fill_in :password_confirmation, with: 'password'
    click_on 'Submit'

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("Logged in as #{user.first_name}")
    expect(page).to have_content("This account has not yet been activated. Please check your email.")
  end

  scenario 'user can visit url explicitly' do
    user = create(:user)

    visit "/activate?user_id=#{user.id}"

    expect(current_path).to eq('/dashboard')
    expect(user.activated).to eq(true)
  end
end
