Rails.application.routes.draw do
  namespace :admin do
    resources :accounts
    resources :iaa_gtcs
    resources :iaa_orders
    resources :integrations
    resources :users
    resources :account_contacts, only: %i[index show new create destroy]
    resources :integration_contacts, only: %i[index show new create destroy]
    resources :agencies
    resources :account_statuses
    resources :iaa_statuses
    resources :integration_statuses

    root to: "accounts#index"
  end

  devise_for :users, skip: [:sessions]

  devise_scope :user do
    get '/users/logout' => 'users/sessions#destroy', as: :destroy_user_session
    get 'active'  => 'users/sessions#active'
    get 'timeout' => 'users/sessions#timeout'
  end

  get '/auth/logindotgov/callback' => 'users/omniauth#callback'

  resources :accounts, only: [:index, :show]

  root to: 'home#index'
end
