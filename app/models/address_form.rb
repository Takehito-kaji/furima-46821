class AddressForm
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id,
                :city, :block, :building, :phone_number, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :token

    validates :postal_code, presence: { message: "can't be blank" }
    validates :prefecture_id, presence: { message: "can't be blank" }
    validates :city, presence: { message: "can't be blank" }
    validates :block, presence: { message: "can't be blank" }
    validates :phone_number, presence: { message: "can't be blank" }
  end

  validates :postal_code,
            format: {
              with: /\A\d{3}-\d{4}\z/,
              message: 'is invalid. Enter it as follows (e.g. 123-4567)'
            }

  validates :prefecture_id,
            numericality: {
              other_than: 1,
              message: "can't be blank"
            }

  validates :phone_number,
            format: {
              with: /\A\d+\z/,
              message: 'is invalid. Input only number'
            }

  validates :phone_number,
            length: {
              minimum: 10,
              message: 'is too short'
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
