Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show] do
    resources :friendships, only: [:new, :create, :update, :destroy] do
      member do
        post 'accept', to: 'friendships#confirm'
        post 'reject', to: 'friendships#reject'
        post 'destroy', to: 'friendships#destroy'
      end
    end
  end

  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
