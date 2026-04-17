class AddColumnsToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :category_id, :integer, null: false
    add_column :items, :condition_id, :integer, null: false
    add_column :items, :delivery_fee_id, :integer, null: false
    add_column :items, :prefecture_id, :integer, null: false
    add_column :items, :delivery_day_id, :integer, null: false
    add_column :items, :price, :integer, null: false
    add_reference :items, :user, null: false, foreign_key: true
  end
end