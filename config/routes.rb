Rails.application.routes.draw do
  root 'home#show'

  get '/auth/fitbit', as: :login
  get '/auth/fitbit/callback', to: 'sessions#create'

  resources :dashboard, only: [:index]
  resources :notifications
  resources :profile, only: [:show]
  resources :goals

  delete '/logout', as: :logout, to: 'sessions#destroy'
end
