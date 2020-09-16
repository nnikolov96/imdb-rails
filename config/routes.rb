Rails.application.routes.draw do

  resources :users
  get "signup" => "users#new"
  resources :movies do
    resources :reviews
    resources :favorites, only: %i[create destroy]
  end

  resource :session, only: %i[new create destroy]
  root 'movies#index'
end
