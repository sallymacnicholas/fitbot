Rails.application.routes.draw do
  root 'home#show'

  resources :dashboard, only: [:index]
end
