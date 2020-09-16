require 'rails_helper'

RSpec.feature 'User can create movies' do
  before do
    visit '/'
    click_link 'Add Movie'
  end

  scenario 'with valid attributes' do
    fill_in 'Title', with: 'AVENGERS ASSEMBLE'
    fill_in 'Description', with: 'Some long and messy description with more than 25 chars'
    fill_in 'Total gross', with: 128371283712
    select  'PG', :from => 'movie[rating]'
    select_date_and_time(2.days.from_now, from:"movie_released_on")
    fill_in 'Director', with: 'Nolan'
    fill_in 'Duration', with: '127'
    click_button 'Create Movie'
    expect(page).to have_content 'Movie was created'
    expect(page).to have_content 'AVENGERS ASSEMBLE'
  end

  scenario 'with invalid attributes' do
    click_button 'Create Movie'
    expect(page).to have_content 'Movie could not be created'
    expect(page).to have_content 'Oops! Your form could not be saved.'
  end
end