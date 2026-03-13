# テーブル設計

# users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| last_name_kanji    | string | null: false | 
| first_name_kanji   | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birthday           | date   | null: false |

### Association

- User has_many :items
- User has_many :buys

## items テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| name                  | string  | null: false |
| description           | text    | null: false |
| category_id           | integer | null: false |
| condition_id          | integer | null: false |
| delivery_fee_id       | integer | null: false |
| prefecture _id        | integer | null: false |
| delivery_day_id       | integer | null: false |
| price                 | integer | null: false |
| user                  | references | null: false, foreign_key: true |

### Association

- Item belongs_to :User
- Item has_one :buy

## buysテーブル

| Column             | Type       | Options    |
| ------------------ | ------     | -----------|
| user               | references | null: false, foreign_key: true |
| item               | references | null: false, foreign_key: true |

### Association

- Buys belongs_to :user
- Buys belongs_to :item
- Buys has_one    :address

## addresses テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| postal_code        | string | null: false |
| prefecture         | string | null: false |
| city               | string | null: false |
| block              | string | null: false |
| building           | string |             |
| phone_number       | string | null: false |
| buy                | references | null: false, foreign_key: true|

### Association

- Address belongs_to :buy
