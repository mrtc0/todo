Rails.application.routes.draw do
  root to: 'tasks#index'

  # Admin
  namespace :admin do
    get 'users', to: 'users#index'
    put 'users/edit/:id', to: 'users#update', as: 'user_edit'
  end

  # Signup
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

  # Task
  resources :tasks
end
