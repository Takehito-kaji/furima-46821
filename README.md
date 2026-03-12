# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | unique: true|
| encrypted_password | string | null: false |
| last_name_kanji    | string | null: false |
| first_name_kanji   | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birthday           | text   | null: false |

### Association

- User has_many :items
- User has_many :buys

## itemsテーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| image              | string | null: false |
| name               | string | null: false |
| description        | text   | null: false |
| category           | string | null: false |
| condition          | string | null: false |
| delivery_fee       | string | null: false |
| region             | string | null: false |
| delivery_day       | string | null: false |
| price              | string | null: false |
| user               | references | null: false, foreign_key: true |

### Association

- Item has_one :User
- Item has_one :buy

## buysテーブル

| Column             | Type       | Options    |
| ------------------ | ------     | -----------|
| user               | references | null: false, foreign_key: true |
| item               | references | null: false, foreign_key: true |

### Association

- Buys belongs_to :user
- Buys belongs_to :item
- Buys belongs_to :address

## addresses テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| address            | text   | null: false |
| prefecture         | string | null: false |
| city               | text   | null: false |
| block              | text   | null: false |
| building           | string |             |
| phone_number       | string | unique: true |
| buy                | references | null: false, foreign_key: true|

### Association

- Address belongs_to :buy

