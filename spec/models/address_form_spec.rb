require 'rails_helper'

RSpec.describe AddressForm, type: :model do
  before do
    @address_form = FactoryBot.build(:address_form)
  end

  # =========================
  # 正しい場合（保存できる）
  # =========================
  context '保存できる場合' do
    it '全て正しい値なら保存できる' do
      expect(@address_form).to be_valid
    end

    it '建物名がなくても保存できる' do
      @address_form.building = ''
      expect(@address_form).to be_valid
    end
  end

  # =========================
  # 正しくない場合（保存できない）
  # =========================
  context '保存できない場合' do
    it '郵便番号が空だと保存できない' do
      @address_form.postal_code = ''
      @address_form.valid?
      expect(@address_form.errors.full_messages)
        .to include("Postal code can't be blank")
    end

    it '郵便番号がハイフンなしだと保存できない' do
      @address_form.postal_code = '1234567'
      @address_form.valid?
      expect(@address_form.errors.full_messages)
        .to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
    end

    it '都道府県が未選択だと保存できない' do
      @address_form.prefecture_id = 1
      @address_form.valid?
      expect(@address_form.errors.full_messages)
        .to include("Prefecture can't be blank")
    end

    it '市区町村が空だと保存できない' do
      @address_form.city = ''
      @address_form.valid?
      expect(@address_form.errors.full_messages)
        .to include("City can't be blank")
    end

    it '番地が空だと保存できない' do
      @address_form.block = ''
      @address_form.valid?
      expect(@address_form.errors.full_messages)
        .to include("Block can't be blank")
    end

    it '電話番号が空だと保存できない' do
      @address_form.phone_number = ''
      @address_form.valid?
      expect(@address_form.errors.full_messages)
        .to include("Phone number can't be blank")
    end

    it '電話番号にハイフンがあると保存できない' do
      @address_form.phone_number = '090-1234-5678'
      @address_form.valid?
      expect(@address_form.errors.full_messages)
        .to include('Phone number is invalid. Input only number')
    end

    it '電話番号が短いと保存できない' do
      @address_form.phone_number = '090123456'
      @address_form.valid?
      expect(@address_form.errors.full_messages)
        .to include('Phone number is too short')
    end
  end
end
