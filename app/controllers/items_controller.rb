# app/controllers/items_controller.rb
class ItemsController < ApplicationController
  # -------------------------------
  # ログイン・出品者制御
  # -------------------------------
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy] # 出品者以外はトップへ

  # -------------------------------
  # 出品中の商品一覧
  # -------------------------------
  def index
    @items = Item.all.order(created_at: :desc)
  end

  # 商品詳細
  def show
  end

  # 新規出品
  def new
    @item = Item.new
  end

  # 商品作成
  def create
    @item = Item.new(item_params.merge(user_id: current_user.id))

    if @item.save
      redirect_to root_path, notice: '商品を出品しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # 編集画面
  def edit
    # move_to_index により出品者でない場合はここには来れない
  end

  # 更新処理
  def update
    # 画像が未選択なら更新対象から除外
    params[:item].delete(:image) if params[:item][:image].blank?

    if @item.update(item_params)
      redirect_to @item, notice: '商品情報を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # 商品削除（オプション）
  def destroy
    @item.destroy
    redirect_to root_path, notice: '商品を削除しました'
  end

  private

  # -------------------------------
  # IDに基づいて商品を取得
  # -------------------------------
  def set_item
    @item = Item.find(params[:id])
  end

  # -------------------------------
  # 出品者以外はトップページにリダイレクト
  # -------------------------------
  def move_to_index
    redirect_to root_path, alert: '不正なアクセスです' unless @item.user == current_user
  end

  # -------------------------------
  # ストロングパラメータ
  # -------------------------------
  def item_params
    params.require(:item).permit(
      :name,
      :description,
      :category_id,
      :condition_id,
      :delivery_fee_id,
      :prefecture_id,
      :delivery_day_id,
      :price,
      :image
    )
  end
end
