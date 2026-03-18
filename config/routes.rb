Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"

  resources :items do
    resources :orders, only: [:index]
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions
  get "up" => "rails/health#show", as: :rails_health_check
end
