Rails.application.routes.draw do
  resources :users

  resources :rooms do 
    resources :reviews, only: [:create, :update], module: :rooms
  end
  
  resource :confirmation, only: [:show]
  resource :user_sessions, only: [:create, :new, :destroy]

  root to: 'home#index'
end
