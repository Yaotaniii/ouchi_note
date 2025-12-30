Rails.application.routes.draw do
  get 'occupants/new'
  get 'occupants/create'
  get 'occupants/destroy'
  devise_for :users

  get "dashboard", to: "dashboard#index"
  root "dashboard#index"

  get "help", to: "help#index"

  resources :rooms do
    resources :rent_histories, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :room_photos, only: [:index, :new, :create, :destroy]
  end
  resources :residents do
    resource :contract, only: [:show, :new, :create, :edit, :update, :destroy]
    resources :occupants, only: [:new, :create, :destroy]
  end
  resources :payments
  resources :maintenance_records
  resources :parking_spaces, only: [:index, :edit, :update]
  resources :bicycle_registrations
  resources :motorcycle_registrations
  resources :vehicles
  resources :incidents
  resources :users, only: [:index, :new, :create, :edit, :update, :destroy]

  get "up" => "rails/health#show", as: :rails_health_check
end