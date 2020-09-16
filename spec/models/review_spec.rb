require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:review) { FactoryBot.create(:review) }
  it 'has a valid factory' do
    expect(review).to be_valid
  end
  it 'is not valid with too short comment' do
    review.comment = 'sh'
    expect(review).to_not be_valid
    expect(review.errors[:comment]).to include 'is too short (minimum is 4 characters)'
  end
  it 'is not valid when stars not in list' do
    review.stars = 6
    expect(review).to_not be_valid
    expect(review.errors[:stars]).to include 'must be between 1 and 5'
  end
end
