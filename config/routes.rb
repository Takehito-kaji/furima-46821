# config/routes.rb
Rails.application.routes.draw do
  # Deviseユーザー認証
  devise_for :users

  # ユーザー詳細ページ
  resources :users, only: [:show], constraints: { id: /\d+/ }

  # トップページ
  root to: "items#index"

  # 商品関連ルート
  resources :items do
    # 購入用ルート（createのみ）
    resources :buys, only: [:create]
  end

  # 任意のヘルスチェック
  get "up" => "rails/health#show", as: :rails_health_check
end