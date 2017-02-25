Rails.application.routes.draw do
  resources :users, only: [:new, :create] do
    resources :stores, only: [:new, :create, :destroy, :show], shallow: true
  end

  # Authenticated user dashboard page
  get '/settings', to: 'users#settings'

  # Session handling routes
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root to: 'sessions#new'
end
