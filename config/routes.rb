Rails.application.routes.draw do
  devise_for :users
  resources :transactions
  resources :accounts, only: [:edit, :update]
  root 'home#index'
end
