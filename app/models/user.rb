class User < ApplicationRecord
  has_many :items
  has_many :buys

  # Devise 標準モジュール
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 必須項目（名字・名前それぞれ必須）
  validates :nickname, :birth_date, presence: true
  validates :last_name_kanji, :first_name_kanji,
            :last_name_kana, :first_name_kana,
            presence: true

  # お名前（全角）
  VALID_NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  validates :last_name_kanji, :first_name_kanji,
            format: { with: VALID_NAME_REGEX, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }

  # お名前カナ（全角カタカナ）
  VALID_KANA_REGEX = /\A[ァ-ヶー]+\z/
  validates :last_name_kana, :first_name_kana,
            format: { with: VALID_KANA_REGEX, message: 'は全角カタカナで入力してください' }

  # パスワード（Deviseと役割分担）
  VALID_PASSWORD_REGEX = /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/
  validates :password,
            format: { with: VALID_PASSWORD_REGEX, message: 'は半角英数字混合で入力してください' },
            if: :password_required?
end
