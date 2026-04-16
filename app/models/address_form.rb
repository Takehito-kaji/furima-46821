class AddressForm
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id,
                :city, :block, :building, :phone_number, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :token
    validates :postal_code
    validates :city
    validates :block
    validates :phone_number
  end

  # 郵便番号
  validates :postal_code,
            format: {
              with: /\A\d{3}-\d{4}\z/,
              message: 'is invalid'
            }

  # 都道府県
  validates :prefecture_id,
            numericality: {
              other_than: 1,
              message: 'must be other than 1'
            }

  # 電話番号
  validates :phone_number,
            format: {
              with: /\A\d{10,11}\z/,
              message: 'is invalid'
            }

  def save
    buy = Buy.create!(user_id: user_id, item_id: item_id)

    Address.create!(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      block: block,
      building: building,
      phone_number: phone_number,
      buy_id: buy.id
    )
  end
end
