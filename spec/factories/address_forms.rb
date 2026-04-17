FactoryBot.define do
  factory :address_form do
    token { 'tok_123456' }
    city { '東京' }
    postal_code { '123-4567' }
    block { '1-1-1' }
    phone_number { '09012345678' }
    prefecture_id { 2 }
  end
end
