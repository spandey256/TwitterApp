Twitter::Application.routes.draw do
  devise_for :users
  resources :home
  resources :profile
  resources :connection
  resources :notification
  root :to => 'home#index'
end
