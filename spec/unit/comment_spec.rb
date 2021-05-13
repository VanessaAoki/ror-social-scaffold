require 'rails_helper'

RSpec.describe 'Create new comment', type: :feature do
  let(:user) { User.create(name: 'Foo Bar', email: 'foo@bar.com', password: '12345678') }
  scenario 'Create comment' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    fill_in :post_content, with: 'HELLOOO'
    click_on 'Save'
    fill_in :comment_content, with: 'very good!'
    click_on 'Comment'
    expect(page).to have_content('very good!')
  end

  scenario 'Comment in blank' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    fill_in :post_content, with: 'HELLOOO'
    click_on 'Save'
    fill_in :comment_content, with: ''
    click_on 'Comment'
    expect(page).to have_content("Content can't be blank")
  end
end