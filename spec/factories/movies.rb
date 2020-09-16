FactoryBot.define do
  factory :movie do
    title { 'Avengers' }
    rating { 'PG' }
    total_gross { 255555555 }
    duration { '127' }
    released_on { 1.year.ago }
    director { 'Christopher Nolan' }
    description { 'Not a real movie but a test one for this factory' }
  end
end