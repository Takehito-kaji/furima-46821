# config/routes.rb
Rails.application.routes.draw do
  # ---------------------------
  # Devise のユーザー認証ルート
  # ---------------------------
  # ログイン、ログアウト、登録など
  devise_for :users

  # ---------------------------
  # ユーザー詳細ページ
  # ---------------------------
  # :id は数字のみ許可して Devise の sign_out と衝突を避ける
  resources :users, only: [:show], constraints: { id: /\d+/ }

  # ---------------------------
  # アプリのトップページ
  # ---------------------------
  root to: "items#index"

  # ---------------------------
  # 商品関連ルート
  # ---------------------------
  resources :items do
    # 商品に紐づく注文ページ（購入）
    resources :orders, only: [:index, :show]
  end

  # ---------------------------
  # ヘルスチェック用（任意）
  # ---------------------------
  get "up" => "rails/health#show", as: :rails_health_check
end