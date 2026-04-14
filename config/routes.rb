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
    # 変更点：購入画面の表示(index)と、購入処理(create)の両方を設定します
    resources :buys, only: [:index, :create]
  end

  # 任意のヘルスチェック
  get "up" => "rails/health#show", as: :rails_health_check
end