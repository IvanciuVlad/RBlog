Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'
  get 'my_friends', to: 'users#my_friends'
  get 'search_friend', to: 'users#search'
  resources :friendships, only: [:create, :destroy]
  resources :articles
end
