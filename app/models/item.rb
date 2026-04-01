class Item < ApplicationRecord
  # ActiveHash を使う場合に必要
  extend ActiveHash::Associations::ActiveRecordExtensions

  # -----------------------------------
  # アソシエーション
  # -----------------------------------
  belongs_to :user
  # has_one :buy

  # -----------------------------------
  # ActiveStorageで画像アップロード（商品画像用）
  # -----------------------------------
  has_one_attached :image

  # -----------------------------------
  # Item モデルに ActiveHash を紐付ける
  # -----------------------------------
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :delivery_day

  #-----------------------------------
  # バリデーション
  #-----------------------------------
  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }

  # ActiveHash の「---」(id: 1) 選択防止
  validates :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :delivery_day_id,
            presence: { message: "can't be blank" },
            numericality: { only_integer: true, other_than: 1, message: 'must be other than 1' }

  # 価格バリデーション
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  # 画像とユーザーの紐付け
  validates :image, presence: true
  validates :user, presence: true
end
