Rails.application.routes.draw do
  get 'login', to: 'session#new'
  post 'login', to: 'session#create'
  delete 'logout', to: 'session#destroy'
  root to: 'tasks#index'
  resources :tasks
end
