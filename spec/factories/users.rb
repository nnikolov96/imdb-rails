FactoryBot.define do
  factory :user do
    name { 'Nikola' }
    email { 'nikola@gmail.com' }
    password { 'Test1234#' }
    password_confirmation { 'Test1234#' }

    trait :admin do
      admin { true }
    end
  end
end