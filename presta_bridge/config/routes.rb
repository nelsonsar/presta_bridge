Rails.application.routes.draw do
  resources :users, only: [:new, :create]

  # Session handling routes
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root to: 'sessions#new'
end
