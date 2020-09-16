require 'rails_helper'

RSpec.feature 'User can destroy movies' do
  before do
    FactoryBot.create(:movie, title: 'Avengers')
    visit '/'
    click_link 'Avengers'
  end

  scenario 'with success' do
    click_link 'Delete'
    expect(page).to_not have_content 'Avengers'
    expect(page).to have_content 'Movie was deleted'
  end
end