Rails.application.routes.draw do
  resources :reservations
  resources :real_estates
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'reservations#index'
end
