Rails.application.routes.draw do
  resources :projects, only: [:new, :create] do
    get 'new/boards', to: 'projects#new_boards', on: :collection
    get 'new/form', to: 'projects#form', on: :collection
  end
  resources :tasks, only: [:show] do
    #moving
    member do
      post :done, to: 'tasks#done'
    end
  end
  devise_for :users
  root to: 'pages#home'
  resources :tasks, only: [ :index, :create] do
    resources :reviews, only: [:create, :index]
    resources :missions, only: :create
  end
  resources :reviews, only: [:show]
  resources :missions, only: [:show] do
    collection do
      post :pause
    end
  end
  get '/users/connect_trello_account', to: 'users#connect_trello_account'
  get '/users/connect_trello_account_callback', to: 'users#connect_trello_account_callback'

  get 'users/boards', to: 'users#boards'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
