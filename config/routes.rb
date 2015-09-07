Mybooks::Application.routes.draw do
  root to: 'pages#front'
  get '/home', to: 'books#index'
  get '/register', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  get '/sign_out', to: 'sessions#destroy'
  get '/reading_queue', to: 'queue_items#index'

  resources :books, only: [:show] do
    resources :reviews, only: [:create]
  end

  resources :users, only: [:create]
  resources :sessions, only: [:create]
  resources :notes, except: [:destroy]
  resources :categories, only: [:show]
  resources :queue_items, only: [:create, :destroy]
  post 'update_queue', to: 'queue_items#update_queue'
end
