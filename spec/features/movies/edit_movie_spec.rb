require 'rails_helper'

RSpec.feature 'User can create movies' do
  let(:user) { FactoryBot.create(:user, :admin) }
  let!(:movie) { FactoryBot.create(:movie, title: 'Avengers') }

  context 'when logged in as admin' do
    before do
      sign_in_as(user.email, user.password)
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

  context 'when logged in as normal user or not logged in' do
    scenario 'hidden links' do
      visit movie_path(movie)
      expect(page).to_not have_link 'Edit'
    end
    scenario 'visiting route' do
      visit edit_movie_path(movie)
      expect(page).to have_content 'Please sign in'
    end
  end
end