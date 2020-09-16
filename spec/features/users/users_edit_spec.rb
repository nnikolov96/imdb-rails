require 'rails_helper'

RSpec.feature 'User can edit account name' do
  let(:user) { FactoryBot.create(:user, name: 'Niki', email: 'niki@gmail.com', password: 'Test1234#') }
  let(:second_user) { FactoryBot.create(:user, name: 'Ivan', email: 'ivan@gmail.com', password: 'Test1234#') }

  context 'on his account' do
    before do
      sign_in_as(user.email, user.password)
      click_link 'Account Settings'
    end
    scenario 'with valid attributes' do
      fill_in 'Name', with: "#{user.name} updated"
      click_button 'Update User'
      expect(page).to have_content 'Account was updated'
      expect(page).to have_content "#{user.name} updated"
    end
    scenario 'with invalid attributes' do
      fill_in 'Name', with: ''
      click_button 'Update User'
      expect(page).to have_content 'We couldnt update your account'
      expect(page).to have_content 'Oops! Your form could not be saved.' 
    end
  end

  context 'not on his account' do
    before do
      sign_in_as(second_user.email, user.password)
    end
    scenario 'links shoud be hidden' do
      visit user_path(user)
      expect(page).to_not have_content 'Edit Account'
    end
    scenario 'should be redirected whne visiting route' do
      visit edit_user_path(user)
      expect(page).to have_content 'You are not authorized to do that!'
        expect(page).to have_current_path(root_path)
    end
  end
end