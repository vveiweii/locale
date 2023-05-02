Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get 'dashboard', to: 'pages#userdashboard'

  resources :users, only: [:show, :edit, :update, :destroy] do
    resources :bookings, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    resources :businesses, only: [:new, :create, :edit, :update, :destroy] do
      resources :services, only: [:new, :create, :edit, :update, :destroy]
    end
  end

  resources :businesses, only: [:index, :show] do
    resources :services, only: [:index]
  end
end
