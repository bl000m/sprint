Rails.application.routes.draw do
  get 'projects/new'
  devise_for :users
  root to: 'tasks#index'
  resources :tasks, only: :show do
    resources :reviews, only: [:create, :show, :index]
  end
  get '/users/connect_trello_account', to: 'users#connect_trello_account'
  get '/users/connect_trello_account_callback', to: 'users#connect_trello_account_callback'

  get 'users/boards', to: 'users#boards'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
