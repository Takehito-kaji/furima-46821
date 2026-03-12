# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| name               | string | null: false |
| email              | string | unique: true|
| phone_number       | string | unique: true |
| birthday           | text   | null: false |
| password           | string | null: false |

### Association

- User has_many :items
- User has_many :buys

## itemsテーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| name               | string | null: false |
| category           | string | null: false |
| price              | string | null: false |
| seller             | string | null: false |

### Association

- Item belongs_to :User
- Item belongs_to :buys

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
| name               | string | null: false |
| address            | string | null: false |
| city               | string | null: false |
| building_name      | string |             |
| email              | string | unique: true|
| phone_number       | string | unique: true |

### Association

- Address belongs_to :buys

