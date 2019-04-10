Rails.application.routes.draw do
  devise_for :users
  resources :transactions
  root 'home#index'
end
