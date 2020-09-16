require 'rails_helper'

RSpec.feature 'User can create movies' do
  before do
    FactoryBot.create(:movie, title: 'Avengers')
    visit '/'
    click_link 'Avengers'
    click_link 'Edit'
  end

  scenario 'with valid attributes' do
    fill_in 'Title', with: 'Avengers updated'

    click_button 'Update Movie'
    expect(page).to have_content 'Movie was updated'
    expect(page).to have_content 'Avengers updated'
  end

  scenario 'with invalid attributes' do
    fill_in 'Title', with: ''
    click_button 'Update Movie'
    expect(page).to have_content 'Movie could not be updated'
    expect(page).to have_content 'Oops! Your form could not be saved.'
  end
end