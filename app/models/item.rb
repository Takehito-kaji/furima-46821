# app/models/item.rb
class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_one_attached :image
  has_one :buy # 1商品につき1購入

  # ActiveHash
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :delivery_day

  # バリデーション
  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :delivery_day_id,
            presence: { message: "can't be blank" },
            numericality: { only_integer: true, other_than: 1, message: 'must be other than 1' }
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :image, presence: true
  validates :user, presence: true

  # -------------------------------
  # 売り切れ判定
  # -------------------------------
  def sold_out?
    buy.present?
  end
end
