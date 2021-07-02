Rails.application.routes.draw do
  devise_for :users
  resources :transactions
  root 'home#index'

  resources :amas, except: [:show] do
    post :state_update, on: :member
  end
end
