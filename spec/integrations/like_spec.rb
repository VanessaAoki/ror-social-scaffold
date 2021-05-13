require 'rails_helper'

RSpec.describe 'Likes', type: :feature do
  let(:user) { User.create(name: 'Foo Bar', email: 'foo@bar.com', password: '12345678') }
  scenario 'Like post' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    fill_in :post_content, with: 'HELLOOO'
    click_on 'Save'
    click_on 'Like!'
    expect(page).to have_content('Dislike!')
  end

  scenario 'Dislike post' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    fill_in :post_content, with: 'HELLOOO'
    click_on 'Save'
    click_on 'Like!'
    click_on 'Dislike!'
    expect(page).to have_content('Like!')
  end
end
