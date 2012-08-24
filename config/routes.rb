Testrails::Application.routes.draw do

  root :to => 'discussions#index'

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"

  resources :users
  resource :sessions
  resources :discussions do
    post :bonk
  end

end

