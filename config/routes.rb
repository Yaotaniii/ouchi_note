Rails.application.routes.draw do
  devise_for :users

  get "dashboard", to: "dashboard#index"
  root "dashboard#index"

  resources :rooms
  resources :residents do
    resource :contract, only: [:show, :new, :create, :edit, :update, :destroy]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end