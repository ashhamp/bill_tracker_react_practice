Rails.application.routes.draw do
  root "welcome#index"

  devise_for :users, controllers: {
    sessions: 'sessions', registrations: 'registrations'
  }

  resources :bills

  resources :payments, only: [:create, :update, :delete]
end
