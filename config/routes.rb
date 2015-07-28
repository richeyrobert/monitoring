Rails.application.routes.draw do
  resources :devtypes
  resources :device_types
  namespace :admin, path: 'admin' do
    resources :devices do 
      resources :backups do
        resources :configs
      end
    end
  end
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
