Rails.application.routes.draw do
  namespace :admin, path: 'admin' do
    resources :devices do 
      resources :backups do
        resources :configurations
      end
    end
  end
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
