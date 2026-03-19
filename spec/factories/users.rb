FactoryBot.define do
  factory :user do
    nickname              { 'テスト太郎' }
    last_name_kanji       { '山田' }
    first_name_kanji      { '太郎' }
    last_name_kana        { 'ヤマダ' }
    first_name_kana       { 'タロウ' }
    birth_date            { '1990-01-01' }
    email                 { 'test@example.com' } # ←まず固定値でテスト
    password              { 'password14' }
    password_confirmation { 'password14' }
  end
end
