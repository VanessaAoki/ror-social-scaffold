Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show] do
    member do
      post 'accept', to: 'friendships#confirm'
      post 'reject', to: 'friendships#reject'
    end
  end

  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
  
  resources :friendships, only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
