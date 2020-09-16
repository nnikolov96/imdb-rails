require 'rails_helper'

RSpec.feature 'user can favorite movies' do
  let!(:user) { FactoryBot.create(:user, name: 'Niki', email: 'niki@gmail.com', password: 'Test1234#') }
  let!(:movie) { FactoryBot.create(:movie) }
  
  context 'when logged in' do
    before do
      sign_in_as(user.email, user.password)
    end
    scenario 'when not favorite' do
      visit movie_path(movie)
      click_button 'Fave'
      within('.movie-details') do
        expect(page).to have_content user.name
      end
      expect(page).to have_content 'Movie added to favorites'
    end

    scenario 'when already favorite' do
      movie.favorites.create!(user: user)
      visit movie_path(movie)
      click_button 'Unfave'
      expect(page).to have_content 'Movie removed from favorites'
    end
  end

  context 'when not logged in' do
    scenario 'hidden buttons' do
      visit movie_path(movie)
      expect(page).to_not have_selector(:link_or_button, 'Fave')
      expect(page).to_not have_selector(:link_or_button, 'Unfave')
    end
  end
end