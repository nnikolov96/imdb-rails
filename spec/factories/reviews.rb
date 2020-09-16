FactoryBot.define do
  factory :review do
    comment { 'Some Comment' }
    stars { 2 }
    association :movie
    association :user
  end
end