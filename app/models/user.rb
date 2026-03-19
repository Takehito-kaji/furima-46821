class User < ApplicationRecord
  # Devise 標準モジュール
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 必須項目
  validates :nickname, :last_name_kanji, :first_name_kanji,
            :last_name_kana, :first_name_kana, :birth_date, presence: true

  # メールアドレスのバリデーション
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'は@を含む必要があります' }

  # パスワードのバリデーション
  VALID_PASSWORD_REGEX = /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/
  validates :password, presence: true,
                       length: { minimum: 6, message: 'は6文字以上で入力してください' },
                       format: { with: VALID_PASSWORD_REGEX, message: 'は半角英数字混合で入力してください' },
                       confirmation: { message: 'と確認用パスワードが一致しません' }
  validates :password_confirmation, presence: true
end
