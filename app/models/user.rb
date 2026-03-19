class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 必須項目
  validates :nickname, :email, :last_name_kanji, :first_name_kanji,
            :last_name_kana, :first_name_kana, :birth_date, presence: true

  # メールアドレスのバリデーション
  validates :email, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'は@を含む必要があります' }

  # パスワードのバリデーション
  validates :password, presence: true, length: { minimum: 6 },
                       format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: 'は半角英数字混合で入力してください' }, confirmation: true, if: :password_required?

  # パスワード確認用
  validates :password_confirmation, presence: true, if: :password_required?

  private

  # パスワードが必要かどうか（Devise の更新時にも対応）
  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end
