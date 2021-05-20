Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users, path: '', path_names: { sign_up: 'register', sign_in: 'login', sign_out: 'logout' }

  resources :users, only: [:index, :show]
  resources :friendships, only: [:index, :create, :destroy, :update]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end