Rails.application.routes.draw do
  devise_for :users

  # ヘルスチェック用（そのまま残す）
  get "up" => "rails/health#show", as: :rails_health_check
end