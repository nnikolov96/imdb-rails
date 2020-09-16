require 'rails_helper'

RSpec.feature 'user can sign up' do
  before do
    FactoryBot.create(:user, email: 'niki@gmail.com', password: 'Test1234#', name: 'Niki')
    visit '/'
    click_link 'Sign In'
  end

  scenario 'with valid arguments' do
    fill_in 'Email', with: 'niki@gmail.com'
    fill_in 'Password', with: 'Test1234#'
    click_button 'Submit'
    expect(page).to have_content 'Welcome back, Niki'
    expect(page).to have_content 'Sign out'
  end

  scenario 'with invalid arguments' do
    fill_in 'Email', with: 'niki@gmail.com'
    fill_in 'Password', with: 'NotRealPassword#'
    click_button 'Submit'
    expect(page).to have_content 'Invalid email/password combination!'
  end
end