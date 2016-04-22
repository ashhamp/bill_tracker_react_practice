Rails.application.routes.draw do
  root "welcome#index"

  devise_for :users

  resources :bills

  resources :payments, only: [:create]
end
