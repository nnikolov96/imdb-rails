require 'rails_helper'

RSpec.feature 'user can signup ' do
  before do
    visit '/'
    click_link 'Sign Up'
  end

  scenario 'with valid attributes' do
    fill_in 'Email', with: 'Nikola@gmail.com'
    fill_in 'Name', with: 'Nikola'
    fill_in 'Password', with: 'Test1234#'
    fill_in 'Confirm Password', with: 'Test1234#'
    click_button 'Create User'
    expect(page).to have_content 'Thanks for signing up!'
    expect(page).to have_content 'Nikola'
  end

  scenario 'with invalid attributes' do
    click_button 'Create User'
    expect(page).to have_content 'You couldnt sign up'
    expect(page).to have_content 'Oops! Your form could not be saved.'
  end
end