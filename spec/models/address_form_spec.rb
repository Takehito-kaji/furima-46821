require 'rails_helper'

RSpec.describe AddressForm, type: :model do
  before do
    # ① userのレコードをDBに保存して作成
    @user = create(:user)

    # ② itemも同様にDBに保存して作成
    @item = create(:item)

    # ③ フォームオブジェクト作成時にIDを渡す
    @address_form = build(:address_form,
                          user_id: @user.id,
                          item_id: @item.id)
  end

  describe '購入情報の保存' do
    context '正常系' do
      it '正しく入力されていれば保存できる' do
        expect(@address_form).to be_valid
      end

      it 'buildingは空でもOK（仕様にあるなら）' do
        expect(@address_form).to be_valid
      end
    end

    context '異常系' do
      it 'postal_codeが空なら無効' do
        @address_form.postal_code = ''
        @address_form.valid?
        expect(@address_form.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeが不正形式なら無効' do
        @address_form.postal_code = '1234567'
        @address_form.valid?
        expect(@address_form.errors.full_messages).to include('Postal code is invalid')
      end

      it 'prefecture_idが1なら無効' do
        @address_form.prefecture_id = 1
        @address_form.valid?
        expect(@address_form.errors.full_messages).to include('Prefecture must be other than 1')
      end

      it 'blockが空なら無効' do
        @address_form.block = ''
        @address_form.valid?
        expect(@address_form.errors.full_messages).to include("Block can't be blank")
      end

      it 'phone_numberが空なら無効' do
        @address_form.phone_number = ''
        @address_form.valid?
        expect(@address_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが10〜11桁以外なら無効' do
        @address_form.phone_number = '090123456'
        @address_form.valid?
        expect(@address_form.errors.full_messages).to include('Phone number is invalid')
      end

      it 'item_idが空なら無効' do
        @address_form.item_id = nil
        @address_form.valid?
        expect(@address_form.errors.full_messages).to include("Item can't be blank")
      end

      it 'user_idが空なら無効' do
        @address_form.user_id = nil
        @address_form.valid?
        expect(@address_form.errors.full_messages).to include("User can't be blank")
      end
    end
  end
end
