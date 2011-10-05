Rent::Application.routes.draw do
  get "login" => "sessions#new", :as => "login"
  get "logout" => "sessions#destroy", :as => "logout"

  resources :users
  resources :sessions
    
  get "sessions/new"

  get "users/new"

  resources :companies

  resources :selections

  resources :statuses

  resources :cids

  resources :dids

  resources :comments

  resources :listings

  root :to => "home#index"

end
