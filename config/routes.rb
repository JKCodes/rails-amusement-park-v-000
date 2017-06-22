Rails.application.routes.draw do

  root "welcome#home"

  get "/signin" => "sessions#new"
  post "/sessions/create" => 'sessions#create'
  delete "/signout" => "sessions#destroy"

  post "/rides/new" => "rides#new"

  resources :attractions
  resources :users
end
