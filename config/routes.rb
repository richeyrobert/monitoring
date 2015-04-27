Rails.application.routes.draw do
  resources :devices
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
