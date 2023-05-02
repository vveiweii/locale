Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"
  get 'dashboard', to: 'pages#userdashboard'

  namespace :users do
    resource :profile, only: %i[show edit update destroy]
    resources :bookings
    resources :businesses do
      resources :services
    end
  end

  resources :businesses, only: %i[index show] do
    resources :services, only: [:index]
  end

  # resource :booking_confirmation, only: [:show]
end
