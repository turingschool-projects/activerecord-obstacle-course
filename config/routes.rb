Rails.application.routes.draw do
  root 'items#index'

  resources :items, only: [:index, :show]
  resources :orders, only: [:index, :show]
  resources :users, only: [:index, :show]
end
