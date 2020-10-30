Rails.application.routes.draw do
  namespace :admin do
      resources :users
      resources :accounts

      root to: "users#index"
    end
  devise_for :users
  devise_for :users, skip: [:sessions]

  devise_scope :user do
    get '/users/logout' => 'users/sessions#destroy', as: :destroy_user_session
    get 'active'  => 'users/sessions#active'
    get 'timeout' => 'users/sessions#timeout'
  end

  get '/auth/logindotgov/callback' => 'users/omniauth#callback'
  get 'users/none' => 'users#none'

  resources :users

  get '/accounts/all' => 'accounts#all'
  resources :accounts

  root to: 'home#index'
end
