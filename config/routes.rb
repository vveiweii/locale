Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"

  resources :dashboard, only: %i[index update destroy]

  resources :users, only: %i[edit update destroy] do
    resources :bookings, only: %i[new create edit update destroy]
    resources :businesses, only: %i[new create edit update destroy] do
      resources :services, only: %i[new create edit update destroy]
    end
  end

  resources :bookings, only: %i[index show]

  resources :businesses, only: %i[index show] do
    resources :services, only: %i[index]
  end

  # resource :booking_confirmation, only: [:show]
end
