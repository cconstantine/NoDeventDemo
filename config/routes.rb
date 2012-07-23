Testrails::Application.routes.draw do

  root :to => 'public#show'
  resource :public, :controller => :public

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"

  resources :users
  resources :sessions
  resources :discussions

end

