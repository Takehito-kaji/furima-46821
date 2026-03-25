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
        user.valid?
        expect(user.errors.full_messages).to include("Nickname can't be blank")
      end

      it '生年月日が空だと無効' do
        user.birth_date = nil
        user.valid?
        expect(user.errors.full_messages).to include("Birth date can't be blank")
      end

      it 'メールアドレスが空だと無効' do
        user.email = ''
        user.valid?
        expect(user.errors.full_messages).to include("Email can't be blank")
      end

      it 'メールアドレスに@が含まれないと無効' do
        user.email = 'test.com'
        user.valid?
        expect(user.errors.full_messages).to include('Email is invalid')
      end

      it 'メールアドレスが重複すると無効' do
        user.save
        another_user = build(:user, email: user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'パスワードが空だと無効' do
        user.password = user.password_confirmation = ''
        user.valid?
        expect(user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードが6文字未満だと無効' do
        user.password = user.password_confirmation = 'a1b2c'
        user.valid?
        expect(user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'パスワードが半角英数字混合でないと無効（英字のみ）' do
        user.password = user.password_confirmation = 'aaaaaa'
        user.valid?
        expect(user.errors.full_messages).to include('Password は半角英数字混合で入力してください')
      end

      it 'パスワードが半角英数字混合でないと無効（数字のみ）' do
        user.password = user.password_confirmation = '123456'
        user.valid?
        expect(user.errors.full_messages).to include('Password は半角英数字混合で入力してください')
      end

      it 'パスワードと確認用パスワードが一致しないと無効' do
        user.password_confirmation = 'password2'
        user.valid?
        expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      # ===== 名前（全角） =====
      it '名字が空だと無効' do
        user.last_name_kanji = ''
        user.valid?
        expect(user.errors.full_messages).to include("Last name kanji can't be blank")
      end

      it '名前が空だと無効' do
        user.first_name_kanji = ''
        user.valid?
        expect(user.errors.full_messages).to include("First name kanji can't be blank")
      end

      it '名字が全角でないと無効' do
        user.last_name_kanji = 'Yamada'
        user.valid?
        expect(user.errors.full_messages).to include('Last name kanji は全角（漢字・ひらがな・カタカナ）で入力してください')
      end

      it '名前が全角でないと無効' do
        user.first_name_kanji = 'Taro'
        user.valid?
        expect(user.errors.full_messages).to include('First name kanji は全角（漢字・ひらがな・カタカナ）で入力してください')
      end

      # ===== カナ =====
      it '名字カナが空だと無効' do
        user.last_name_kana = ''
        user.valid?
        expect(user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it '名前カナが空だと無効' do
        user.first_name_kana = ''
        user.valid?
        expect(user.errors.full_messages).to include("First name kana can't be blank")
      end

      it '名字カナが全角カタカナでないと無効' do
        user.last_name_kana = 'やまだ'
        user.valid?
        expect(user.errors.full_messages).to include('Last name kana は全角カタカナで入力してください')
      end

      it '名前カナが全角カタカナでないと無効' do
        user.first_name_kana = 'たろう'
        user.valid?
        expect(user.errors.full_messages).to include('First name kana は全角カタカナで入力してください')
      end
    end
  end
end
