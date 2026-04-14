FactoryBot.define do
  factory :address_form do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { 'Tokyo' }
    block { '1-1-1' }
    building { 'Building' }
    phone_number { '09012345678' }
    token { 'tok_123456' }

    user_id { 1 }
    item_id { 1 }
  end
end
