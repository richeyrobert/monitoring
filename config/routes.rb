Rails.application.routes.draw do
  namespace :admin, path: 'admin' do
    resources :devtypes
    resources :device_types 
    resources :devices do 
      resources :backups do
        resources :configs
      end
    end
  end
  namespace :api, :defaults => {:format => :xml} do
    namespace :v1 do
      match 'text_test' => 'twilio#text_test', via: [:get]
      # match 'received_fax' => 'director#received_fax', via: [:post]
      # match 'incoming_fax' => 'director#received_fax', via: [:post]
      # match 'add_clip' => 'director#add_clip', via: [:post]
      # match 'query_hold_music_exists' => 'director#query_hold_music_exists', via: [:post]
      # match 'query_sound_clip_exists' => 'director#query_sound_clip_exists', via: [:post]
      # match 'query_fax_exists' => 'director#query_fax_exists', via: [:post]
      # match 'sync_streams' => 'director#sync_streams', via: [:post]
      # match 'update_stream' => 'director#update_stream', via: [:post]
      # match 'create_stream' => 'director#create_stream', via: [:post]
      # match 'remove_stream' => 'director#remove_stream', via: [:post]
      # match 'add_sound_clip' => 'director#add_sound_clip', via: [:post]
      # match 'remove_sound_clip' => 'director#remove_sound_clip', via: [:post]
      # match 'add_hold_music' => 'director#add_hold_music', via: [:post]
      # match 'remove_hold_music' => 'director#remove_hold_music', via: [:post]
      # match 'add_fax' => 'director#add_fax', via: [:post]
      # match 'remove_fax' => 'director#remove_fax', via: [:post]
      # match 'retry_fax' => 'director#retry_fax', via: [:post]
      # match 'update_fax' => 'director#update_fax', via: [:post]
      # match 'pull_config' => 'director#pull_config', via: [:post]
      # match 'fax_success' => 'director#fax_success', via: [:post]
      # match 'fax_failed' => 'director#fax_failed', via: [:post]
      # match 'sync_queue' => 'director#sync_queue', via: [:post]
      # match 'remove_queue' => 'director#remove_queue', via: [:post]
      # match '/*desired_action' => 'director#director', via: [:get, :post, :put]
      # # resources :director
      # root :to => 'director#index'
    end
  end
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
