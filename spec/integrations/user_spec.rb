require 'rails_helper'

RSpec.describe 'Siggin Up', type: :feature do
  scenario 'Sign up with valid inputs' do
    visit new_user_registration_path
    fill_in 'Name', with: 'Foo Bar'
    fill_in 'Email', with: 'foo@bar.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'
    sleep(3)
    visit root_path
    expect(page).to have_content('Foo Bar')
  end

  scenario 'Sign up with invalid inputs' do
    visit new_user_registration_path
    fill_in 'Name', with: ''
    fill_in 'Email', with: 'foo@bar.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'
    sleep(3)
    visit root_path
    expect(page).to_not have_content('Foo Bar')
  end
end

RSpec.describe 'Sign In', type: :feature do
  let(:user) { User.create(name: 'Foo Bar', email: 'foo@bar.com', password: '12345678') }
  scenario 'Log in with valid inputs' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    sleep(3)
    expect(page).to have_content('Foo Bar')
  end

  scenario 'Log in with invalid inputs' do
    visit new_user_session_path
    fill_in 'Email', with: 'Banana'
    fill_in 'Password', with: user.password
    click_on 'Log in'
    sleep(3)
    expect(page).to_not have_content('Foo Bar')
  end
end

RSpec.describe 'Loggin Out', type: :feature do
  let(:user) { User.create(name: 'Foo Bar', email: 'foo@bar.com', password: '12345678') }
  scenario 'Log Out' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    sleep(3)
    click_on 'Sign out'
    sleep(3)
    visit root_path
    expect(page).to have_content('Sign up')
  end
end
