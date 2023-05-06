Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"

  resource :dashboard, only: %i[index update destroy]

  resources :users do
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
