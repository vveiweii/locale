Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :dashboard, only: %i[index update destroy]

  resources :users, only: %i[edit update destroy] do
    resources :bookings, only: %i[new create edit update]
    resources :businesses, only: %i[new create edit update] do
      resources :services, only: %i[new create edit update]
    end
  end

  resources :bookings, only: %i[index show destroy]

  resources :businesses, only: %i[index show destroy] do
    resources :services, only: %i[index destroy]
  end

  # routes related to cart + line_items + booking confirmation
  get 'carts/:id' => "carts#show", as: "cart"
  delete 'carts/:id' => "carts#destroy"

  post 'line_items/:id/add' => "line_items#add_quantity", as: "line_item_add"
  post 'line_items/:id/reduce' => "line_items#reduce_quantity", as: "line_item_reduce"
  post 'line_items' => "line_items#create"
  get 'line_items/:id' => "line_items#show", as: "line_item"
  delete 'line_items/:id' => "line_items#destroy"

  resource :booking_confirmation, only: [:show]

  # route related to the for your business page

  get 'for-your-business', to: 'pages#for_your_business', as: 'for_your_business'
end
