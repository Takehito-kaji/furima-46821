class Item < ApplicationRecord
  # ActiveHash を使う場合に必要
  extend ActiveHash::Associations::ActiveRecordExtensions

  # -----------------------------------
  # アソシエーション
  # -----------------------------------
  belongs_to :user
  has_one :buy

  # -----------------------------------
  # ActiveStorageで画像アップロード（商品画像用）
  # -----------------------------------
  has_one_attached :image

  # -----------------------------------
  # Item モデルに ActiveHash を紐付ける
  # -----------------------------------
  belongs_to_active_hash :category

  #-----------------------------------
  # バリデーション
  # -----------------------------------
  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :category_id, :condition_id, :delivery_fee_id,
            :prefecture_id, :delivery_day_id, :price,
            presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :image, presence: true
end
