# frozen_string_literal: true

require 'rails_helper'

describe 'visitor visits video show page' do
  it 'clicks on the bookmark page and is sent to the log in page' do
    tutorial = create(:tutorial)
    create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)

    expect(page).to have_content('You must login or register to bookmark videos.')
    click_on 'login'
    expect(current_path).to eq(login_path)

    visit tutorial_path(tutorial)
    click_on 'register'
    expect(current_path).to eq(register_path)
  end
end
