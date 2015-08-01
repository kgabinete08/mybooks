Mybooks::Application.routes.draw do
  get '/home', to: 'books#index'
end
