require 'rails_helper'

RSpec.describe Movie, type: :model do
  let(:movie) { FactoryBot.create(:movie) }

  it 'has a valid factory' do
    expect(movie).to be_valid
  end

  it 'is not valid without title' do
    movie.title = nil
    expect(movie).to_not be_valid

    expect(movie.errors[:title]).to include "can't be blank"
  end
  it 'is not valid when description length is less than 25 characters' do
    movie.description = 'short one'
    expect(movie).to_not be_valid
    expect(movie.errors[:description]).to include 'is too short (minimum is 25 characters)'
  end

  it 'is not valid when rating is not included in list' do
    movie.rating = 'not in list'
    expect(movie).to_not be_valid
    expect(movie.errors[:rating]).to include 'is not included in the list'
  end
  it 'is not valid when total gross is not a positive number' do
    movie.total_gross = -5
    expect(movie).to_not be_valid
    expect(movie.errors[:total_gross]).to include 'must be greater than or equal to 0'
  end
end
