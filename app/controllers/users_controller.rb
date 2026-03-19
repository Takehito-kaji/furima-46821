class UsersController < ApplicationController
  # ログイン済みユーザーのみアクセス可能
  before_action :authenticate_user!
  before_action :set_user, only: [:show]

  # ユーザー一覧
  def index
    @users = User.all
  end

  # ユーザー詳細
  def show
  end

  private

  # ユーザーを取得
  def set_user
    @user = User.find(params[:id])
  end
end
