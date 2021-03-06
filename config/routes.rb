Rails.application.routes.draw do

  resources :genres
  resources :users
  get "signup" => "users#new"
  get "movies/filter/:filter" => "movies#index", as: :filtered_movies
  resources :movies do
    resources :reviews
    resources :favorites, only: %i[create destroy]
  end

  resource :session, only: %i[new create destroy]
  root 'movies#index'
end
