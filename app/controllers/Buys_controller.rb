# app/controllers/buys_controller.rb
class BuysController < ApplicationController
  before_action :set_item

  def create
    # ここを修正！
    @buy = Buy.new(user_id: current_user.id, item_id: @item.id)

    if @buy.save
      redirect_to items_path, notice: '購入しました'
    else
      redirect_to items_path, alert: '購入に失敗しました'
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end
end
