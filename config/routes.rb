Rails.application.routes.draw do
  get 'user/new'
  get 'user/create'
  get 'user/show'
  get 'user/edit'
  get 'user/destroy'
  get 'login', to: 'session#new'
  post 'login', to: 'session#create'
  delete 'logout', to: 'session#destroy'
  root to: 'tasks#index'
  resources :tasks
end
