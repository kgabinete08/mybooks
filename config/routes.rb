Mybooks::Application.routes.draw do
  root to: 'pages#front'
  get '/home', to: 'books#index'
  get '/register', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  get '/sign_out', to: 'sessions#destroy'

  resources :books, only: [:show]
  resources :users, only: [:create]
  resources :sessions, only: [:create]
end
