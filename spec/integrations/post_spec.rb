require 'rails_helper'

RSpec.describe 'Create Post', type: :feature do
  let(:user) { User.create(name: 'Foo Bar', email: 'foo@bar.com', password: '12345678') }
  scenario 'Create new post with valid inputs' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    fill_in :post_content, with: 'HELLOOO'
    click_on 'Save'
    expect(page).to have_content('HELLOOO')
  end

  scenario 'Create post with blank inputs' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    fill_in :post_content, with: ''
    click_on 'Save'
    expect(page).to_not have_content('HELLOOO')
  end
end
