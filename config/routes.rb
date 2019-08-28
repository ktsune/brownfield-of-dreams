# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'
  get 'tags/:tag', to: 'welcome#index', as: :tag

  get '/about', to: 'about#show'
  get '/get_started', to: 'get_started#show'

  # Users
  get '/register', to: 'users#new'
  get '/dashboard', to: 'users#show'
  resources :users, only: %i[create update edit]
  post '/friend', to: 'friend#create', as: 'create_friend'
  post '/invite', to: 'invite#create'

  # Sessions
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/auth/github', as: 'github_login'
  get '/auth/github/callback', to: 'sessions#update'
  delete '/logout', to: 'sessions#destroy'

  # Bookmarks
  resources :user_videos, only: %i[create destroy]

  # Tutorials
  resources :tutorials, only: %i[show index] do
    resources :videos, only: %i[show index]
  end

  # API
  namespace :api do
    namespace :v1 do
      resources :tutorials, only: %i[show index]
      resources :videos, only: [:show]
    end
  end

  # Admin
  namespace :admin do
    get '/dashboard', to: 'dashboard#show'

    resources :tutorials, only: %i[create edit update destroy new] do
      resources :videos, only: [:create]
    end
    resources :videos, only: %i[edit update destroy]

    namespace :api do
      namespace :v1 do
        put 'tutorial_sequencer/:tutorial_id', to: 'tutorial_sequencer#update'
      end
    end
  end
end
