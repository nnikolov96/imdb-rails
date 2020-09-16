require 'rails_helper'

RSpec.feature 'User can add reviews' do
  let(:user) { FactoryBot.create(:user, name: 'Niki', email: 'niki@gmail.com', password: 'Test1234#') }
  let(:movie) { FactoryBot.create(:movie)}

  context 'when logged in' do
    before do
      sign_in_as(user.email, user.password)
      visit movie_path(movie)
      click_link 'Write Review'
    end
    scenario 'with valid attributes' do
      select  '3', :from => 'review[stars]'
      fill_in 'Comment', with: 'Average Movie'
      click_on 'Post Review'
      expect(page).to have_content 'Review Submitted'
      within('.reviews') do
        expect(page).to have_content '1 Review' 
      end
    end

    scenario 'with invalid attributes' do
      click_on 'Post Review'
      expect(page).to have_content 'Review could not be created'
      expect(page).to have_content 'Oops! Your form could not be saved.'
    end
  end

  context 'when not logged in' do
    scenario 'is redirected' do
      visit movie_path(movie)
      click_link 'Write Review'
      expect(page).to have_content 'Please sign in'
    end
  end
end