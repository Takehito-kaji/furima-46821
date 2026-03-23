# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'ユーザー登録' do
    it '全ての項目が正しく入力されていれば有効' do
      expect(user).to be_valid
    end

    it 'ニックネームが空だと無効' do
      user.nickname = ''
      expect(user).not_to be_valid
    end

    it 'メールアドレスが空だと無効' do
      user.email = ''
      expect(user).not_to be_valid
    end

    it 'メールアドレスに@が含まれないと無効' do
      user.email = 'test.com'
      expect(user).not_to be_valid
    end

    it 'メールアドレスが重複すると無効' do
      user.save
      another_user = build(:user, email: user.email)
      expect(another_user).not_to be_valid
    end

    it 'パスワードが空だと無効' do
      user.password = user.password_confirmation = ''
      expect(user).not_to be_valid
    end

    it 'パスワードが6文字未満だと無効' do
      user.password = user.password_confirmation = 'a1b2c'
      expect(user).not_to be_valid
    end

    it 'パスワードが半角英数字混合でないと無効' do
      user.password = user.password_confirmation = 'aaaaaa'
      expect(user).not_to be_valid
    end

    it 'パスワードと確認用パスワードが一致しないと無効' do
      user.password_confirmation = 'password2'
      expect(user).not_to be_valid
    end
  end
end
