Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]  # ← これを追加
  root to: "items#index"

  resources :items do
    resources :orders, only: [:index, :show]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
