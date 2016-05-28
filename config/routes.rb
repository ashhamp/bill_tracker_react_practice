Rails.application.routes.draw do
  root "welcome#index"

  devise_for :users, controllers: {
    sessions: 'sessions', registrations: 'registrations'
  }

  resources :bills

  resources :payments, only: [:create, :update, :destroy]

  get 'charts', to: 'charts#index'

  namespace :api do
    resources :bills, only: [:index]
    resources :payments, only: [:create]
  end
end
