require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    let(:user) { build(:user) }

    it '有効なユーザーなら保存できる' do
      expect(user).to be_valid
    end

    context 'メールアドレス' do
      it 'email が空だと無効' do
        user.email = ''
        expect(user).not_to be_valid
      end

      it 'email がユニークでないと無効' do
        create(:user, email: user.email)
        expect(user).not_to be_valid
      end

      it 'email に @ が含まれていないと無効' do
        user.email = 'invalid_email'
        expect(user).not_to be_valid
        expect(user.errors[:email]).to include('must include @')
      end
    end

    context 'パスワード' do
      it 'password が空だと無効' do
        user.password = ''
        user.password_confirmation = ''
        expect(user).not_to be_valid
      end

      it 'password が6文字未満だと無効' do
        user.password = 'a1b2'
        user.password_confirmation = 'a1b2'
        expect(user).not_to be_valid
      end

      it 'password に数字が含まれないと無効' do
        user.password = 'abcdef'
        user.password_confirmation = 'abcdef'
        expect(user).not_to be_valid
        expect(user.errors[:password]).to include('must include both letters and numbers')
      end

      it 'password に英字が含まれないと無効' do
        user.password = '123456'
        user.password_confirmation = '123456'
        expect(user).not_to be_valid
        expect(user.errors[:password]).to include('must include both letters and numbers')
      end

      it 'password と password_confirmation が一致しないと無効' do
        user.password_confirmation = 'different1'
        expect(user).not_to be_valid
      end
    end
  end
end
