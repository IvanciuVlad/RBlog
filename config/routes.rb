Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  get 'my_friends', to: 'users#my_friends'
  get 'search_friend', to: 'users#search'
  resources :friendships, only: %i[create destroy]
  resources :articles do
    put 'like', to: 'articles#upvote'
    put 'dislike', to: 'articles#downvote'
    resources :comments, except: [:index]
  end
  resources :categories, except: [:destroy]
  resources :users, only: [:show]
end
