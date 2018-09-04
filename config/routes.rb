Rails.application.routes.draw do
  root to: 'tasks#index'
  # User Registration
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  # User Edit
  get 'user/show', to: 'users#show'
  patch 'user/edit', to: 'users#edit'
  delete 'user/destroy', to: 'users#delete'

  # Login
  get 'login', to: 'session#new'
  post 'login', to: 'session#create'

  # Logout
  delete 'logout', to: 'session#destroy'
  root to: 'tasks#index'

  # Task
  resources :tasks
end
