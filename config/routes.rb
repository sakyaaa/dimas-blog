# frozen_string_literal: true

Rails.application.routes.draw do
  # Defines the root path route ("/")
  root 'articles#index'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # User accounts
  devise_for :user

  # User profiles
  resources :users, only: %i[index show]

  # Articles and comments
  resources :articles do
    resources :comments, only: %i[index create destroy]
  end
end
