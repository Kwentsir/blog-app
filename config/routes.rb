Rails.application.routes.draw do
  devise_for :users
root to: 'users#index'
get 'likes/create'
get 'comment/new'
get 'comment/create'
resources :users, only: [:index, :show] do
  resources :posts, only: [:index, :show, :new, :create] do
    resources :comments, only: [:index, :create]
    resources :likes, only: [:create]
  end
end
end
