require 'rails_helper'

RSpec.feature 'User can destroy movies' do
  let(:user) { FactoryBot.create(:user, :admin) }
  let!(:movie) { FactoryBot.create(:movie, title: 'Avengers') }

  context 'when logged in as admin' do
    scenario 'with success' do
      sign_in_as(user.email, user.password)
      visit '/'
      click_link 'Avengers'
      click_link 'Delete'
      expect(page).to_not have_content 'Avengers'
      expect(page).to have_content 'Movie was deleted'
    end
  end

  context 'when logged in as normal user or not logged in' do
    scenario 'hidden links' do
      visit movie_path(movie)
      expect(page).to_not have_link 'Delete'
    end
  end
end