class BuysController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index, only: [:index, :create]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @address_form = AddressForm.new
  end

  def create
    @address_form = AddressForm.new(address_params)

    if @address_form.valid?
      ActiveRecord::Base.transaction do
        pay_item
        @address_form.save
      end
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    return unless @item.sold_out? || current_user == @item.user

    redirect_to root_path
  end

  def address_params
    params.require(:address_form).permit(
      :postal_code,
      :prefecture_id,
      :city,
      :block,
      :building,
      :phone_number,
      :token
    ).merge(
      user_id: current_user.id,
      item_id: params[:item_id]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']

    Payjp::Charge.create(
      amount: @item.price,
      card: @address_form.token,
      currency: 'jpy'
    )
  end
end
