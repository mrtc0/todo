Rails.application.routes.draw do
  get 'session/new'
  get 'session/create'
  get 'session/destroy'
  root to: 'tasks#index'
  resources :tasks
end
