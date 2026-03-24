require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'ユーザー登録' do
    context '新規登録できるとき' do
      it '全ての項目が正しく入力されていれば有効' do
        expect(user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'ニックネームが空だと無効' do
        user.nickname = ''
        expect(user).not_to be_valid
      end

      it '生年月日が空だと無効' do
        user.birth_date = nil
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

      it 'パスワードが半角英数字混合でないと無効（英字のみ）' do
        user.password = user.password_confirmation = 'aaaaaa'
        expect(user).not_to be_valid
      end

      it 'パスワードが半角英数字混合でないと無効（数字のみ）' do
        user.password = user.password_confirmation = '123456'
        expect(user).not_to be_valid
      end

      it 'パスワードと確認用パスワードが一致しないと無効' do
        user.password_confirmation = 'password2'
        expect(user).not_to be_valid
      end

      # ===== 名前（全角） =====
      it '名字が空だと無効' do
        user.last_name_kanji = ''
        expect(user).not_to be_valid
      end

      it '名前が空だと無効' do
        user.first_name_kanji = ''
        expect(user).not_to be_valid
      end

      it '名字が全角でないと無効' do
        user.last_name_kanji = 'Yamada'
        expect(user).not_to be_valid
      end

      it '名前が全角でないと無効' do
        user.first_name_kanji = 'Taro'
        expect(user).not_to be_valid
      end

      # ===== カナ =====
      it '名字カナが空だと無効' do
        user.last_name_kana = ''
        expect(user).not_to be_valid
      end

      it '名前カナが空だと無効' do
        user.first_name_kana = ''
        expect(user).not_to be_valid
      end

      it '名字カナが全角カタカナでないと無効' do
        user.last_name_kana = 'やまだ'
        expect(user).not_to be_valid
      end

      it '名前カナが全角カタカナでないと無効' do
        user.first_name_kana = 'たろう'
        expect(user).not_to be_valid
      end
    end
  end
end
