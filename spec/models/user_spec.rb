require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  it 'has a valid factory' do
    expect(user).to be_valid
  end
  
  it 'has a unique email' do
    u = User.new(email: user.email, password: 'Test1234#', name: 'Niki')
    expect(u).to_not be_valid
    expect(u.errors[:email]).to include 'has already been taken'
  end

  it 'is not valid without name' do
    user.name = nil
    expect(user).to_not be_valid
    expect(user.errors[:name]).to include "can't be blank"
  end
end
