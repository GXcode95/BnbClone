Rails.application.routes.draw do
  resources :reservations
  resources :real_estates
  resources :days, only: :destroy

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'reservations#index'
end
