Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  get 'my_friends', to: 'users#my_friends'
  get 'search_friend', to: 'users#search'
  resources :friendships, only: [:create, :destroy]
  resources :articles
  resources :categories, except: [:destroy]
  resources :users, only: [:show]
end
