Rails.application.routes.draw do
  get '/login', to:  'sessions#new'
  post '/login', to:  'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  namespace :admin do
    resources :users
  end

  root to: 'tasks#index'
  get 'tasks/search'
  resources :tasks do
    collection do
      get :priority
      get :to_do
      get :in_progress
      get :done
    end
  end
end
