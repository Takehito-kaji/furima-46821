require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    # 正常系
    context '出品できる場合' do
      it 'すべての項目が正しく入力されていれば出品できる' do
        expect(@item).to be_valid
      end
    end

    # 異常系
    context '出品できない場合' do
      context '商品情報' do
        it '商品名が空では出品できない' do
          @item.name = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Name can't be blank")
        end

        it '商品説明が空では出品できない' do
          @item.description = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Description can't be blank")
        end

        it 'カテゴリーに「---」が選択されている場合は出品できない' do
          @item.category_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Category must be other than 1')
        end

        it '商品の状態に「---」が選択されている場合は出品できない' do
          @item.condition_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Condition must be other than 1')
        end
      end

      context '配送情報' do
        it '配送料の負担に「---」が選択されている場合は出品できない' do
          @item.delivery_fee_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Delivery fee must be other than 1')
        end

        it '発送元の地域に「---」が選択されている場合は出品できない' do
          @item.prefecture_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Prefecture must be other than 1')
        end

        it '発送までの日数に「---」が選択されている場合は出品できない' do
          @item.delivery_day_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Delivery day must be other than 1')
        end
      end

      context '価格情報' do
        it '価格が空では出品できない' do
          @item.price = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Price can't be blank")
        end

        it '価格が300円未満では出品できない' do
          @item.price = 200
          @item.valid?
          expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
        end

        it '価格が9,999,999円を超えると出品できない' do
          @item.price = 10_000_000
          @item.valid?
          expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
        end

        it '価格に半角数字以外が含まれている場合は出品できない' do
          @item.price = '300a'
          @item.valid?
          expect(@item.errors.full_messages).to include('Price is not a number')
        end
      end

      context '画像' do
        it '画像が添付されていないと出品できない' do
          @item.image.detach
          @item.valid?
          expect(@item.errors.full_messages).to include("Image can't be blank")
        end
      end

      context 'ユーザー情報' do
        it 'userが紐付いていなければ出品できない' do
          @item.user = nil
          @item.valid?
          expect(@item.errors.full_messages).to include('User must exist')
        end
      end
    end
  end
end
