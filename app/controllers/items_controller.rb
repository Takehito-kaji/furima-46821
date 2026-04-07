class ItemsController < ApplicationController
  # 新規出品や作成、編集・更新時はログイン必須
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_item, only: [:show, :edit, :update]

  # ★ これを追加（editだけに適用）
  before_action :move_to_index, only: [:edit]

  # 出品中の商品一覧
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
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '商品を出品しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # 編集画面
  def edit
  end

  # 更新処理
  def update
    params[:item].delete(:image) if params[:item][:image].blank?

    if @item.update(item_params)
      redirect_to @item, notice: '商品情報を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # IDに基づいて商品を取得
  def set_item
    @item = Item.find(params[:id])
  end

  # ★ これを追加
  def move_to_index
    redirect_to root_path unless @item.user == current_user
  end

  # ストロングパラメータ
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
    ).merge(user_id: current_user.id)
  end
end
