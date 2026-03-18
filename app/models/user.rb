class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ------------------------------
  # メールアドレスバリデーション
  # ------------------------------
  validates :email, uniqueness: true
  validates :email, format: { with: /@/, message: 'must include @' }

  # ------------------------------
  # パスワードバリデーション
  # ------------------------------
  # Devise の password と password_confirmation を対象にバリデーション
  validates :password,
            presence: true,                 # 入力必須
            length: { minimum: 6 },         # 6文字以上
            format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/,
                      message: 'must include both letters and numbers' },
            confirmation: true              # password_confirmation と一致必須

  # 確認用パスワードも対象に明示的に指定（任意）
  validates :password_confirmation, presence: true
end
